class AddressesController < ApplicationController
  before_action :set_address, only: [:show, :edit, :update, :destroy]

  respond_to :json, :xml, :html

  # GET /addresses
  def index
    @addresses = Address.all
  end

  # GET /addresses/1
  def show
    rpc = BitcoinRPC.new Pollux::RPCURL
#    @address.balance = rpc.getbalance
  end

  # GET /addresses/new
  def new
    @address = Address.new
  end

  # GET /addresses/1/edit
  def edit
  end

  # POST /addresses
  def create
    @address = Address.new address_params
    rpc = BitcoinRPC.new Pollux::RPCURL
    @address.address = rpc.getnewaddress
    @address.balance = 0.0
    @address.save
    respond_with @address
  end

  # PATCH/PUT /addresses/1
  def update
    @address.update address_params
  end

  # DELETE /addresses/1
  def destroy
    @address.destroy
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
end
