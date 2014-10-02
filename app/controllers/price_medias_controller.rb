class PriceMediasController < ApplicationController

  before_filter :admin_required

  # GET /price_medias
  # GET /price_medias.xml
  def index
    @price_medias = PriceMedia.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @price_medias }
    end
  end

  # GET /price_medias/1
  # GET /price_medias/1.xml
  def show
    @price_media = PriceMedia.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @price_media }
    end
  end

  # GET /price_medias/new
  # GET /price_medias/new.xml
  def new
    @price_media             = PriceMedia.new
    @price_usage             = PriceUsage.find(params[:id])
    @price_media.price_usage = @price_usage
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @price_media }
    end
  end

  # GET /price_medias/1/edit
  def edit
    @price_media = PriceMedia.find(params[:id])
    # @price_usage = PriceUsage.find(params[:parent])
  end

  # POST /price_medias
  # POST /price_medias.xml
  def create
    @price_media = PriceMedia.new(params[:price_media])

    respond_to do |format|
      if @price_media.save
        flash[:notice] = 'PriceMedia was successfully created.'
        format.html { redirect_to(@price_media.price_usage) }
        format.xml  { render :xml => @price_media, :status => :created, :location => @price_media }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @price_media.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /price_medias/1
  # PUT /price_medias/1.xml
  def update
    @price_media = PriceMedia.find(params[:id])

    respond_to do |format|
      if @price_media.update_attributes(params[:price_media])
        flash[:notice] = 'PriceMedia was successfully updated.'
        format.html { redirect_to(@price_media.price_usage) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @price_media.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /price_medias/1
  # DELETE /price_medias/1.xml
  def destroy
    @price_media = PriceMedia.find(params[:id])
    @price_media.destroy

    respond_to do |format|
      format.html { redirect_to(@price_media.price_usage) }
      format.xml  { head :ok }
    end
  end
end
