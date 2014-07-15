class AddressesController < ApplicationController
  before_action :set_address, only: [:show, :edit, :update, :destroy]
  before_filter :load_user

  respond_to :json, :xml, :html

  # GET /addresses
  def index
    @addresses = @user.addresses.all
    respond_with @addresses
  end

  # GET /addresses/1
  def show
    @address = @user.addresses.find params[:id]
    rpc = BitcoinRPC.new Pollux::RPCURL
#    @address.balance = rpc.getbalance
    respond_with @address
  end

  # GET /addresses/new
  def new
    @address = @user.addresses.new
    respond_with @address
  end

  # GET /addresses/1/edit
  def edit
    @address = @user.addresses.find params[:id]
    respond_with @address
  end

  # POST /addresses
  def create
    @address = @user.addresses.new address_params
    rpc = BitcoinRPC.new Pollux::RPCURL
    @address.address = rpc.getnewaddress
    @address.balance = 0.0
    @address.save
    respond_with [@user, @address]
  end

  # PATCH/PUT /addresses/1
  def update
    @address = @user.addresses.find params[:id]
    @address.update address_params
    respond_with [@user, @address]
  end

  # DELETE /addresses/1
  def destroy
    @address = @user.addresses.find params[:id]
    @address.destroy
    respond_with [@user, @address]
  end

  # GET /addresses/getbalance
  def getbalance
    rpc = BitcoinRPC.new Pollux::RPCURL
    respond_with ret = { :resp => rpc.getbalance }, :location => nil and return
  end

  # GET /addresses/listaccounts
  def listaccounts
    rpc = BitcoinRPC.new Pollux::RPCURL
    respond_with ret = { :resp => rpc.listaccounts }, :location => nil and return
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = Address.find params[:id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def address_params
      params.require(:address).permit(:user_id, :address, :balance)
    end

    def load_user
      @user = User.find params[:user_id]
    end
end
