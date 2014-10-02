class ProductUseDurationsController < ApplicationController
    
    before_filter :admin_required
  # GET /product_use_durations
  # GET /product_use_durations.xml
  def index
    @product_use_durations = ProductUseDuration.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @product_use_durations }
    end
  end

  # GET /product_use_durations/1
  # GET /product_use_durations/1.xml
  def show
    @product_use_duration = ProductUseDuration.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product_use_duration }
    end
  end

  # GET /product_use_durations/new
  # GET /product_use_durations/new.xml
  def new
    @product_use_duration = ProductUseDuration.new
    @product_categories   = ProductCategory.find(:all)
    @product_use_duration.product_categories << @product_categories[params[:id].to_i-1] if params[:id]

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product_use_duration }
    end
  end

  # GET /product_use_durations/1/edit
  def edit
    @product_use_duration = ProductUseDuration.find(params[:id])
    @product_categories   = ProductCategory.find(:all)
  end

  # POST /product_use_durations
  # POST /product_use_durations.xml
  def create
    @product_use_duration = ProductUseDuration.new(params[:product_use_duration])
    checked_features      = check_features_using_helper( params[:product_durations_list], ProductCategory, @product_use_duration.product_categories )
    respond_to do |format|
      if @product_use_duration.save
        flash[:notice] = 'ProductUseDuration was successfully created.'
        format.html { redirect_to :controller => 'product_categories', :action => "index" }
        format.xml  { render :xml => @product_use_duration, :status => :created, :location => @product_use_duration }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product_use_duration.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /product_use_durations/1
  # PUT /product_use_durations/1.xml
  def update
    @product_use_duration = ProductUseDuration.find(params[:id])
    @product_categories   = ProductCategory.find(:all)
    checked_features      = check_features_using_helper( params[:product_durations_list], ProductCategory, @product_use_duration.product_categories )
    uncheck_missing_features_helper( @product_categories, checked_features, @product_use_duration.product_categories )

    respond_to do |format|
      if @product_use_duration.update_attributes(params[:product_use_duration])
        flash[:notice] = 'ProductUseDuration was successfully updated.'
        format.html { redirect_to :controller => 'product_categories', :action => "index" }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product_use_duration.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /product_use_durations/1
  # DELETE /product_use_durations/1.xml
  def destroy
    @product_use_duration = ProductUseDuration.find(params[:id])
    @product_use_duration.destroy

    respond_to do |format|
      format.html { redirect_to :action => 'index' }
      format.xml  { head :ok }
    end
  end
end
