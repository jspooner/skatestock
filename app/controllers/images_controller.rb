class ImagesController < ApplicationController
  before_filter :login_required, :except => [:show] 
  # GET /images
  # GET /images.xml
  def index
    if current_user.is_admin
      @images = Image.masters.find(:all)
    else
      @images = Image.this_user(current_user).masters.find(:all)
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @images }
    end
  end

  # GET /images/1
  # GET /images/1.xml
  # 
  # Image state is private sale
  #   • anyone can view and buy the image
  # Image is off line
  #   • redirect to somewhere
  # Image is editorial
  #   • Display the editorial version
  # Image is stock
  #   • Display the stock version  
  # 
  def show
    @image = Image.find(params[:id])
    # Image is off line
    #   • redirect to somewhere
    if @image.product_type == "offline" and current_user == nil
      redirect_to('/login')
      return
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @image }
    end
  end

  # GET /images/new
  # GET /images/new.xml
  def new
    @image = Image.new(:user => current_user)
    if params[:image_shell_id] && params[:request_id]
      @image.image_shell = ImageShell.find(params[:image_shell_id])
      @image.description = @image.image_shell.description
      @image.request     = Request.find(params[:request_id])       
    end
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @image }
    end
  end

  # GET /images/1/edit
  def edit
    @image = Image.find(params[:id])
  end

  # POST /images
  # POST /images.xml
  def create
    @image             = Image.new(params[:image])
    @image.description = Description.new(params[:description])                  if @image.description == nil
    @image.image_shell = ImageShell.find(params[:image_shell][:image_shell_id]) if params[:image_shell]
    
    if params[:request]
      r = Request.find(params[:request][:request_id])
      r.action_was_taken!
      @image.owner_request = r
    end
    
    respond_to do |format|
      if @image.save
        flash[:notice] = (@image.owner_request) ? "We'll review your modifications and get back to you." : 'Image was successfully created.'
        format.html { redirect_to(@image) }
        format.xml  { render :xml => @image, :status => :created, :location => @image }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @image.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /images/1
  # PUT /images/1.xml
  def update
    @image = Image.find(params[:id])
    
    respond_to do |format|
      if @image.update_attributes(params[:image]) && @image.description.update_attributes(params[:description])
        flash[:notice] = 'Image was successfully updated.'
        format.html { redirect_to(@image) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @image.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.xml
  def destroy
    @image = Image.find(params[:id])
    @image.destroy

    respond_to do |format|
      format.html { redirect_to(images_url) }
      format.xml  { head :ok }
    end
  end
  
  
  
end
