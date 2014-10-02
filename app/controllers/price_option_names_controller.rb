class PriceOptionNamesController < ApplicationController
  before_filter :admin_required  
  # GET /price_option_names
  # GET /price_option_names.xml
  def index
    @price_option_names = PriceOptionName.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @price_option_names }
    end
  end

  # GET /price_option_names/1
  # GET /price_option_names/1.xml
  def show
    @price_option_name = PriceOptionName.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @price_option_name }
    end
  end

  # GET /price_option_names/new
  # GET /price_option_names/new.xml
  def new
    @price_option_name = PriceOptionName.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @price_option_name }
    end
  end

  # GET /price_option_names/1/edit
  def edit
    @price_option_name = PriceOptionName.find(params[:id])
  end

  # POST /price_option_names
  # POST /price_option_names.xml
  def create
    @price_option_name = PriceOptionName.new(params[:price_option_name])

    respond_to do |format|
      if @price_option_name.save
        flash[:notice] = 'PriceOptionName was successfully created.'
        format.html { redirect_to(price_option_names_path) }
        format.xml  { render :xml => @price_option_name, :status => :created, :location => @price_option_name }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @price_option_name.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /price_option_names/1
  # PUT /price_option_names/1.xml
  def update
    @price_option_name = PriceOptionName.find(params[:id])

    respond_to do |format|
      if @price_option_name.update_attributes(params[:price_option_name])
        flash[:notice] = 'PriceOptionName was successfully updated.'
        format.html { redirect_to(@price_option_name) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @price_option_name.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /price_option_names/1
  # DELETE /price_option_names/1.xml
  def destroy
    @price_option_name = PriceOptionName.find(params[:id])
    @price_option_name.destroy

    respond_to do |format|
      format.html { redirect_to(price_option_names_url) }
      format.xml  { head :ok }
    end
  end
end
