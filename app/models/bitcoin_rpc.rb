require 'net/http'
require 'net/https'
require 'uri'
require 'json'
 
class BitcoinRPC
  def initialize(service_url)
    @uri = URI.parse(service_url)
  end
 
  def method_missing(name, *args)
    post_body = { 'method' => name, 'params' => args, 'id' => 'jsonrpc' }.to_json
    resp = JSON.parse( http_post_request(post_body) )
    raise JSONRPCError, resp['error'] if resp['error']
    resp['result']
  end
 
  def http_post_request(post_body)
    http = Net::HTTP.new(@uri.host, @uri.port)
    if @uri.scheme == "https"
        http.use_ssl = true
        http.ca_file = "/home/wgq/.bitcoin/server.cert"
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    end
    request = Net::HTTP::Post.new(@uri.request_uri)
    request.basic_auth @uri.user, @uri.password
    request.content_type = 'application/json'
    request.body = post_body
    http.request(request).body
  end
 
  class JSONRPCError < RuntimeError; end
end
