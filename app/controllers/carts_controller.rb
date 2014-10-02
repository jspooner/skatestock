class CartsController < ApplicationController
  include ActiveMerchant::Billing::Integrations

  protect_from_forgery :except => [:thankyou]
  before_filter :login_required
  
  # GET /carts
  # GET /carts.xml
  def index
    @cart             = current_cart if params[:id] == nil
    @cart             = Cart.find(params[:id]) if params[:id] != nil
    @option_names     = PriceOptionName.find(:all)
    @current_user     = current_user
    @cart.total_price = @cart.get_total_price
    @cart.save
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @carts }
    end
  end

  def thankyou
  end


end
