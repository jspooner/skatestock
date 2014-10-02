class ProofsController < ApplicationController
  before_filter :login_required
  # GET /proofs
  # GET /proofs.xml
  def index
    view = params["view"]
    if current_user.my_group == "admin"
      # @proofs = Proof.images.paginate(:page => params[:page], :per_page => 20)                   if view == nil
      @proofs = Proof.images.list(params[:page])                  if view == nil
      @proofs = Proof.images.accepted_images.list(params[:page])  if view == "approved"
      @proofs = Proof.images.pending_images.list(params[:page])   if view == "pending"
      @proofs = Proof.images.complete_images.list(params[:page])  if view == "complete"
    else
      @proofs = Proof.images.this_user(current_user).list(params[:page])                  if view == nil
      @proofs = Proof.images.accepted_images.this_user(current_user).list(params[:page])  if view == "approved"
      @proofs = Proof.images.pending_images.this_user(current_user).list(params[:page])   if view == "pending"
      @proofs = Proof.images.complete_images.this_user(current_user).list(params[:page])  if view == "complete"
    end
     #   @posts = Post.paginate_by_board_id @board.id, :page => params[:page], :order => 'updated_at DESC'
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @proofs }
    end
  end

  # GET /proofs/1
  # GET /proofs/1.xml
  def show
    @proof = Proof.find(params[:id])
    
    respond_to do |format|
      format.html #{ render :layout => 'calculator' } # show.html.erb
      format.xml  { render :xml => @proof }
    end
    
  end

  # GET /proofs/new
  # GET /proofs/new.xml
  def new
    @proof      = Proof.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @proof }
    end
  end

  # GET /proofs/1/edit
  def edit
    @proof = Proof.find(params[:id])
  end

  # POST /proofs
  # POST /proofs.xml
  def create
    @proof              = Proof.new(params[:proof])
    @proof.user         = current_user
    respond_to do |format|
      if @proof.save
        flash[:notice] = 'Proof was successfully created.'
        # ON SECOND UPLOAD THIS REDIRECTS TO THE WRONG PAGE
        format.html { redirect_to new_user_proof_path(current_user) }
        format.xml  { render :xml => @proof, :status => :created, :location => @proof }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @proof.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /proofs/1
  # PUT /proofs/1.xml
  def update
    @proof = Proof.find(params[:id])
    @proof.approve_image! if params[:proof][:state] == "approved"
    respond_to do |format|
      if @proof.update_attributes(params[:proof])
        flash[:notice] = 'Proof was successfully updated.'
        format.html { 
            path      = proofs_path + "/?view=pending"
            nextProof = Proof.next(@proof)
            path      = edit_proof_path( nextProof )  if nextProof
            redirect_to(path) 
          }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @proof.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /proofs/1
  # DELETE /proofs/1.xml
  def destroy
    @proof = Proof.find(params[:id])
    @proof.destroy

    respond_to do |format|
      format.html { redirect_to(proofs_url) }
      format.xml  { head :ok }
    end
  end
  
end
