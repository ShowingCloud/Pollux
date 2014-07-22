require 'digest/sha2'
require 'openssl/cipher'
require 'base64'

module PasswordCrypt

  def encrypt_password
    params = self

    cipher = OpenSSL::Cipher::Cipher.new('DES3').tap do |c|
      c.encrypt
      c.key = Pollux::MembershipSecretToken

      iv = Digest::SHA256.new.tap do |i|
        i.update params[:username]
        c.iv = i.hexdigest
      end

      result = c.update params[:password]
      result << c.final
      params[:password] = Base64.strict_encode64 result
    end

    params
  end

  def decrypt_password
    params = self

    begin
      pswd = Base64.strict_decode64 params[:password]

      cipher = OpenSSL::Cipher::Cipher.new('DES3').tap do |c|
        c.decrypt
        c.key = Pollux::MembershipSecretToken

        iv = Digest::SHA256.new.tap do |i|
          i.update params[:username]
          c.iv = i.hexdigest
        end

        clearpswd = c.update pswd
        clearpswd << c.final
        params[:password] = clearpswd
      end

    rescue
      Rails.logger.error $!.backtrace
    end

    params
  end

  def hash_with_captcha captcha
    params = self

    hash = Digest::SHA256.new.tap do |h|
      h.update params[:password]
      h.update captcha
      params[:password] = h.hexdigest
    end

    params
  end

end
