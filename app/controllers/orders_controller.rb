class OrdersController < ApplicationController
  
  before_filter :admin_required
  
  def index
    if params[:show] == "all"
      @carts = Cart.find(:all) 
    else
      @carts = Cart.paid 
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @carts }
    end
  end

  def show
    @cart = Cart.find(params[:id])
    
  end

  def thankyou
  end

end
