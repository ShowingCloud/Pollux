class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  respond_to :json, :xml, :html

  # GET /users
  def index
    @users = User.includes(:addresses).all
    respond_with @users
  end

  # GET /users/1
  def show
    @user = User.includes(:addresses).find params[:id]
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
    @address = @user.addresses.new
    rpc = BitcoinRPC.new Pollux::RPCURL
    @address.address = rpc.getnewaddress @user.uuid
    @address.balance = 0.0
    @address.save
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find params[:id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :password, :email,
                                  addresses_attributes: [:address, :balance])
    end
end
