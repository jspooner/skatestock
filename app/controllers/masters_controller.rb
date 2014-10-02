class MastersController < ApplicationController
  before_filter :login_required
  
  
  # GET /masters
  # GET /masters.xml
  def index
    view = params["view"]
    if current_user.my_group == "admin"
      @masters = Master.images                  if view == nil
      @masters = Master.images.accepted_images  if view == "approved"
      @masters = Master.images.pending_images   if view == "pending"
      @masters = Master.images.complete_images  if view == "complete"
    else
      @masters = Master.images.this_user(current_user)                  if view == nil
      @masters = Master.images.accepted_images.this_user(current_user)  if view == "approved"
      @masters = Master.images.pending_images.this_user(current_user)   if view == "pending"
      @masters = Master.images.active_images.this_user(current_user)    if view == "active"
      @masters = Master.images.sold_images.this_user(current_user)      if view == "sold"
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @masters }
    end
  end

  # GET /masters/1
  # GET /masters/1.xml
  def show
    @master = Master.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @master }
    end
  end

  # GET /masters/new
  # GET /masters/new.xml
  def new
    @proof = Proof.find(params[:proof_id])    
    @master = Master.new(:proof => @proof, :user => current_user)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @master }
    end
  end

  # GET /masters/1/edit
  def edit
    @master = Master.find(params[:id])
  end

  # POST /masters
  # POST /masters.xml
  def create
    @master = Master.new(params[:master])
    
    respond_to do |format|
      if @master.save
        flash[:notice] = 'Master was successfully created.'
        format.html { redirect_to("/proofs/?view=approved") }
        format.xml  { render :xml => @master, :status => :created, :location => @master }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @master.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /masters/1
  # PUT /masters/1.xml
  def update
    @master = Master.find(params[:id])

    respond_to do |format|
      if @master.update_attributes(params[:master])
        flash[:notice] = 'Master was successfully updated.'
        format.html { 
            path      = masters_path + "/?view=pending"
            nextMaster= Master.next(@master)
            path      = edit_master_path( nextMaster )  if nextMaster
            redirect_to(path) 
          }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @master.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /masters/1
  # DELETE /masters/1.xml
  def destroy
    @master = Master.find(params[:id])
    @master.destroy

    respond_to do |format|
      format.html { redirect_to(masters_url) }
      format.xml  { head :ok }
    end
  end
    
end
