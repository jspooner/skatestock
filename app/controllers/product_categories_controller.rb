class ProductCategoriesController < ApplicationController

  # Protect these actions behind an admin login
  # before_filter :login_required  
  before_filter :admin_required
  
  # GET /product_categories
  # GET /product_categories.xml
  def index
    @product_category = ProductCategory.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @product_category }
    end
  end

  # GET /product_categories/1
  # GET /product_categories/1.xml
  def show
    @product_category = ProductCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product_category }
    end
  end

  # GET /product_categories/new
  # GET /product_categories/new.xml
  def new
    @product_category = ProductCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product_category }
    end
  end

  # GET /product_categories/1/edit
  def edit
    @product_categories = ProductCategory.find(params[:id])
  end

  # POST /product_categories
  # POST /product_categories.xml
  def create
    @product_category = ProductCategory.new(params[:product_category])

    respond_to do |format|
      if @product_category.save
        flash[:notice] = 'ProductCategories was successfully created.'
        format.html { redirect_to :action => 'index' }
        format.xml  { render :xml => @product_category, :status => :created, :location => @product_categories }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /product_categories/1
  # PUT /product_categories/1.xml
  def update
    @product_categories = ProductCategory.find(params[:id])

    respond_to do |format|
      if @product_categories.update_attributes(params[:product_category])
        flash[:notice] = 'ProductCategories was successfully updated.'
        format.html { redirect_to :action => 'index' }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /product_categories/1
  # DELETE /product_categories/1.xml
  def destroy
    @product_categories = ProductCategories.find(params[:id])
    @product_categories.destroy

    respond_to do |format|
      # format.html { redirect_to(product_categories_url) }
      format.html { redirect_to :action => 'index' }
      format.xml  { head :ok }
    end
  end
end
