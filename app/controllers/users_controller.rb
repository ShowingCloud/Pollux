require 'digest/sha2'
require 'openssl/cipher'
require 'base64'

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  respond_to :json, :xml, :html

  # GET /users
  def index
    @users = User.includes(:addresses).all
    @users.each do |user|
      user.addresses.each do |addr|
        addr.balance = BitcoinRPC.new.getreceivedbyaddress addr.address
        addr.save! if addr.changed?
      end
    end
    respond_with @users
  end

  # GET /users/1
  def show
    @user = User.includes(:addresses).find params[:id]
    @user.addresses.each do |addr|
      addr.balance = BitcoinRPC.new.getreceivedbyaddress addr.address
      addr.save! if addr.changed?
    end
    respond_with @user
  end

  # GET /users/new
  def new
    @user = User.new
    respond_with @user
  end

  # GET /users/1/edit
  def edit
    @user = User.find params[:id]
    respond_with @user
  end

  # POST /users
  def create
    @user = User.new user_params
    @user.save
    @address = @user.addresses.new.tap do |add|
      add.address = BitcoinRPC.new.getnewaddress @user.uuid
      add.balance = 0.0
      add.save
    end
    respond_with @user
  end

  # PATCH/PUT /users/1
  def update
    @user = User.find params[:id]
    @user.update user_params
    respond_with @user
  end

  # DELETE /users/1
  def destroy
    @user = User.find params[:id]
    @user.destroy
    respond_with @user
  end

  # /users/login
  def login
    @user = User.find_by_username(params[:username]).decrypt_password

    if params[:password] == @user.password
      session[:username] = params[:username]
      respond_with ret = { :status => 1 }, :location => nil, :status => :accepted and return
    else
      session[:username] = nil
      respond_with ret = { :status => 0, :description => "Wrong password" }, :location => nil, :status => :unauthorized and return
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find params[:id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :password, :email,
                                   addresses_attributes: [:address, :balance]
                                  ).encrypt_password
    end

end
