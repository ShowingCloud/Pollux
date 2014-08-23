class AddressesController < ApplicationController
  before_action :set_address, only: [:show, :edit, :update, :destroy]
  before_action :set_forbidden, except: [:index, :show, :new, :create, :refreshall, :getmore]

  respond_to :json, :xml, :html


  # GET /addresses
  def index
    respond_to do |format|
      format.html {
        @addresses_recent = Address.order(created_at: :desc).limit(6)
        @addresses_hottest = Address.order(balance: :desc).limit(9)
        @total_amount = Address.sum(:balance)
        [@addresses_recent, @addresses_hottest, @total_amount] }
      format.any(:xml, :json) { @addresses = Address.all }
    end
  end

  # GET /addresses/getmore
  def getmore
    @addresses = Address.order(balance: :desc).limit(9).offset(params[:offset])
    respond_with @addresses
  end

  # GET /addresses/1
  def show
    @address.balance = BitcoinRPC.new.getreceivedbyaddress @address.address
    @address.save
    @total_amount = Address.sum(:balance)
    respond_with [@address, @total_amount]
  end

  # GET /addresses/new
  def new
    @address = Address.new
    respond_with @address
  end

  # GET /addresses/1/edit
  def edit
    respond_with @address
  end

  # POST /addresses
  def create
    @address = Address.new address_params
    @address.address = BitcoinRPC.new.getnewaddress @address.nickname
    @address.balance = 0.0
    @address.save
    UserNotifier.send_signup_email(@address).deliver
    respond_with @address
  end

  # PATCH/PUT /addresses/1
  def update
    @address.update address_params
    respond_with @address
  end

  # DELETE /addresses/1
  def destroy
    @address.destroy
    respond_with @address
  end

  # GET /addresses/getbalance
  def getbalance
    respond_with ret = { :resp => BitcoinRPC.new.getbalance }, :location => nil and return
  end

  # GET /addresses/listaccounts
  def listaccounts
    respond_with ret = { :resp => BitcoinRPC.new.listaccounts }, :location => nil and return
  end

  # GET /addresses/refreshall
  def refreshall
    @addresses = Address.all
    @addresses.each do |addr|
      addr.balance = BitcoinRPC.new.getreceivedbyaddress addr.address
      addr.save! if addr.changed?
    end

    respond_with ret = { :resp => BitcoinRPC.new.getbalance }, :location => nil and return
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = Address.find params[:id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def address_params
      params.require(:address).permit(:nickname, :email, :video)
    end

    def set_forbidden
      respond_with ret = { :resp => "forbidden" }, :status => :forbidden do |format|
        format.html { redirect_to :back }
      end and return
    end

end
