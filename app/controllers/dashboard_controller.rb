class DashboardController < ApplicationController
  before_action :check_login, :except => [:new, :create, :login]
  before_action :set_user

  respond_to :json, :xml, :html

  # GET /dashboard
  def index
    refresh_addresses
    respond_with @user
  end

  # GET /dashboard/1
  def show
  end

  # GET /dashboard/refresh
  def refresh
    refresh_addresses
    redirect_to :action => "index"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.includes(:addresses).find_by_username session[:username]
    end

    def check_login
      if not session[:username]
        flash[:notice] = "Please login first"
        redirect_to :controller => "users", :action => "login" and return
      end
    end

  def refresh_addresses
    @user.addresses.each do |addr|
      addr.balance = BitcoinRPC.new.getreceivedbyaddress addr.address
      addr.save! if addr.changed?
    end
  end

end
