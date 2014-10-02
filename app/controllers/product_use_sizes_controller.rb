class ProductUseSizesController < ApplicationController
  include AuthenticatedSystem
  
  # Protect these actions behind an admin login
  before_filter :login_required  

  # GET /product_use_sizes
  # GET /product_use_sizes.xml
  def index
    @product_use_sizes = ProductUseSize.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @product_use_sizes }
    end
  end

  # GET /product_use_sizes/1
  # GET /product_use_sizes/1.xml
  def show
    @product_use_size = ProductUseSize.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product_use_size }
    end
  end

  # GET /product_use_sizes/new
  # GET /product_use_sizes/new.xml
  def new
    @product_use_size   = ProductUseSize.new
    @product_categories = ProductCategory.find(:all)
    @product_use_size.product_categories << @product_categories[params[:id].to_i-1] if params[:id]

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product_use_size }
    end
  end

  # GET /product_use_sizes/1/edit
  def edit
    @product_use_size   = ProductUseSize.find(params[:id])
    @product_categories = ProductCategory.find(:all)
  end

  # POST /product_use_sizes
  # POST /product_use_sizes.xml
  def create
    @product_use_size = ProductUseSize.new(params[:product_use_size])
    checked_features  = check_features_using_helper( params[:product_categories_list], ProductCategory, @product_use_size.product_categories )
    respond_to do |format|
      if @product_use_size.save
        flash[:notice] = 'ProductUseSize was successfully created.'
        format.html { redirect_to :controller => 'product_categories', :action => "index" }
        format.xml  { render :xml => @product_use_size, :status => :created, :location => @product_use_size }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product_use_size.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /product_use_sizes/1
  # PUT /product_use_sizes/1.xml
  def update
    @product_use_size   = ProductUseSize.find(params[:id])
    @product_categories = ProductCategory.find(:all)
    checked_features    = check_features_using_helper( params[:product_categories_list], ProductCategory, @product_use_size.product_categories )
    uncheck_missing_features_helper( @product_categories, checked_features, @product_use_size.product_categories )
      
    respond_to do |format|
      if @product_use_size.update_attributes(params[:product_use_size])
        flash[:notice] = 'ProductUseSize was successfully updated.'
        format.html { redirect_to :controller => 'product_categories', :action => "index" }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product_use_size.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /product_use_sizes/1
  # DELETE /product_use_sizes/1.xml
  def destroy
    @product_use_size = ProductUseSize.find(params[:id])
    @product_use_size.destroy

    respond_to do |format|
      format.html { redirect_to(product_use_sizes_url) }
      format.xml  { head :ok }
    end
  end
end
