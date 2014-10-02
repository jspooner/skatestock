class ProductUsePlacementsController < ApplicationController
  include AuthenticatedSystem
  
  # Protect these actions behind an admin login
  before_filter :login_required  

  # GET /product_use_placements
  # GET /product_use_placements.xml
  def index
    @product_use_placements = ProductUsePlacement.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @product_use_placements }
    end
  end

  # GET /product_use_placements/1
  # GET /product_use_placements/1.xml
  def show
    @product_use_placement = ProductUsePlacement.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product_use_placement }
    end
  end

  # GET /product_use_placements/new
  # GET /product_use_placements/new.xml
  def new
    @product_use_placement = ProductUsePlacement.new
    @product_categories    = ProductCategory.find(:all)
    @product_use_placement.product_categories << @product_categories[params[:id].to_i-1] if params[:id]
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product_use_placement }
    end
  end

  # GET /product_use_placements/1/edit
  def edit
    @product_use_placement = ProductUsePlacement.find(params[:id])
    @product_categories    = ProductCategory.find(:all)
  end

  # POST /product_use_placements
  # POST /product_use_placements.xml
  def create
    @product_use_placement = ProductUsePlacement.new(params[:product_use_placement])
    checked_features       = check_features_using_helper( params[:product_categories_list], ProductCategory, @product_use_placement.product_categories )
    respond_to do |format|
      if @product_use_placement.save
        flash[:notice] = 'ProductUsePlacement was successfully created.'
        format.html { redirect_to :controller => 'product_categories', :action => "index" }
        format.xml  { render :xml => @product_use_placement, :status => :created, :location => @product_use_placement }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product_use_placement.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /product_use_placements/1
  # PUT /product_use_placements/1.xml
  def update
    @product_use_placement = ProductUsePlacement.find(params[:id])
    @product_categories    = ProductCategory.find(:all)
    checked_features       = check_features_using_helper( params[:product_categories_list], ProductCategory, @product_use_placement.product_categories )
    uncheck_missing_features_helper( @product_categories, checked_features, @product_use_placement.product_categories )
    
    respond_to do |format|
      if @product_use_placement.update_attributes(params[:product_use_placement])
        flash[:notice] = 'ProductUsePlacement was successfully updated.'
        format.html { redirect_to :controller => 'product_categories', :action => "index" }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product_use_placement.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /product_use_placements/1
  # DELETE /product_use_placements/1.xml
  def destroy
    @product_use_placement = ProductUsePlacement.find(params[:id])
    @product_use_placement.destroy

    respond_to do |format|
      format.html { redirect_to(product_use_placements_url) }
      format.xml  { head :ok }
    end
  end
end
