class Qrcode
  include HTTParty
  base_uri 'http://chart.apis.google.com'

  def self.qrcode(addr)
    get('/chart', {
      :query => {
        :cht => "qr",
        :chld => "Q|2",
        :chs => "200",
        :chl => addr
      }
    })
  end

end
