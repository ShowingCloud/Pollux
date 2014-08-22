require "base64"

class QrcodesController < ApplicationController

  respond_to :png, :html


  # GET /qrcodes/1
  def show
    @qrcode = Qrcode.qrcode params[:id]
    respond_to do |format|
      format.png { render :text => @qrcode }
      format.html { render :text => "<img alt=\"QR Code\" src=\"data:image/png;base64," + Base64.encode64(@qrcode) + "\" />" }
    end
  end

end
