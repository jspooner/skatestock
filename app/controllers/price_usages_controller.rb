class PriceUsagesController < ApplicationController

  before_filter :admin_required
  
  # GET /price_usages
  # GET /price_usages.xml
  def index
    @price_usages       = PriceUsage.find(:all)
    @price_option_types = ["Placements","Durations","Sizes","Print Run","Exposure"]
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @price_usages }
    end
  end

  # GET /price_usages/1
  # GET /price_usages/1.xml
  def show
    @price_usage = PriceUsage.find(params[:id])
    @options     = PriceOptionName.find(:all)  
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @price_usage }
    end
  end

  # GET /price_usages/new
  # GET /price_usages/new.xml
  def new
    @price_usage = PriceUsage.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @price_usage }
    end
  end

  # GET /price_usages/1/edit
  def edit
    @price_usage = PriceUsage.find(params[:id])
  end

  # POST /price_usages
  # POST /price_usages.xml
  def create
    @price_usage = PriceUsage.new(params[:price_usage])

    respond_to do |format|
      if @price_usage.save
        flash[:notice] = 'PriceUsage was successfully created.'
        format.html { redirect_to :action => 'index' }
        format.xml  { render :xml => @price_usage, :status => :created, :location => @price_usage }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @price_usage.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /price_usages/1
  # PUT /price_usages/1.xml
  def update
    @price_usage = PriceUsage.find(params[:id])

    respond_to do |format|
      if @price_usage.update_attributes(params[:price_usage])
        flash[:notice] = 'PriceUsage was successfully updated.'
        format.html { redirect_to(@price_usage) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @price_usage.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /price_usages/1
  # DELETE /price_usages/1.xml
  def destroy
    @price_usage = PriceUsage.find(params[:id])
    @price_usage.destroy

    respond_to do |format|
      format.html { redirect_to(price_usages_url) }
      format.xml  { head :ok }
    end
  end
end
