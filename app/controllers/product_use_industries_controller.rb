class ProductUseIndustriesController < ApplicationController
  include AuthenticatedSystem
  
  # Protect these actions behind an admin login
  before_filter :login_required  

  # GET /product_use_industries
  # GET /product_use_industries.xml
  def index
    @product_use_industries = ProductUseIndustry.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @product_use_industries }
    end
  end

  # GET /product_use_industries/1
  # GET /product_use_industries/1.xml
  def show
    @product_use_industry = ProductUseIndustry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product_use_industry }
    end
  end

  # GET /product_use_industries/new
  # GET /product_use_industries/new.xml
  def new
    @product_use_industry = ProductUseIndustry.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product_use_industry }
    end
  end

  # GET /product_use_industries/1/edit
  def edit
    @product_use_industry = ProductUseIndustry.find(params[:id])
  end

  # POST /product_use_industries
  # POST /product_use_industries.xml
  def create
    @product_use_industry = ProductUseIndustry.new(params[:product_use_industry])

    respond_to do |format|
      if @product_use_industry.save
        flash[:notice] = 'ProductUseIndustry was successfully created.'
        format.html { redirect_to(@product_use_industry) }
        format.xml  { render :xml => @product_use_industry, :status => :created, :location => @product_use_industry }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product_use_industry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /product_use_industries/1
  # PUT /product_use_industries/1.xml
  def update
    @product_use_industry = ProductUseIndustry.find(params[:id])

    respond_to do |format|
      if @product_use_industry.update_attributes(params[:product_use_industry])
        flash[:notice] = 'ProductUseIndustry was successfully updated.'
        format.html { redirect_to(@product_use_industry) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product_use_industry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /product_use_industries/1
  # DELETE /product_use_industries/1.xml
  def destroy
    @product_use_industry = ProductUseIndustry.find(params[:id])
    @product_use_industry.destroy

    respond_to do |format|
      format.html { redirect_to(product_use_industries_url) }
      format.xml  { head :ok }
    end
  end
end
