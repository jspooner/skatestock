class InvitationsController < ApplicationController
  # GET /invitations
  # GET /invitations.xml
  def index
    @invitations = Invitation.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @invitations }
    end
  end

  # GET /invitations/1
  # GET /invitations/1.xml
  def show
    if params[:ids]
      ids         = params[:ids].split(",")
      @invitation = Invitation.find_by_permalink(ids[0])      
    else
      @invitation = Invitation.find_by_permalink(params[:id])      
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @invitation }
    end
  end

  # GET /invitations/new
  # GET /invitations/new.xml
  def new
    @invitation = Invitation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @invitation }
    end
  end

  # GET /invitations/1/edit
  def edit
    @invitation = Invitation.find_by_permalink(params[:id])
  end

  # POST /invitations
  # POST /invitations.xml
  def create
    @invitation = Invitation.new(params[:invitation])

    respond_to do |format|
      if @invitation.save
        flash[:notice] = 'Invitation was successfully created.'
        
        format.html { redirect_to("/users/#{current_user.id}/invitations/#{@invitation.permalink}") }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /invitations/1
  # PUT /invitations/1.xml
  def update
    @invitation = Invitation.find_by_permalink(params[:id])
    respond_to do |format|
      if @invitation.update_attributes(params[:invitation])
        flash[:notice] = 'Invitation was successfully updated.'
        format.html { redirect_to("/users/#{current_user.id}/invitations/#{@invitation.permalink}") }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @invitation.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def edit_multiple
    @image_shell_id = params[:i]
    @invitation     = Invitation.find( :all, :conditions => {:permalink => params[:ids].split(",") } )
  end
  
  def update_multiple
    @invitations = Invitation.find(params[:invitation_ids])
    i            = 0
    @invitations.each do |invite|
      invite.update_attributes!(:email => params[:invitation_email][i])
      i = i + 1
    end
    flash[:notice] = "Rider info was successfully updated."
    redirect_to "/i/#{params[:image_shell_id]}"
  end
  
  # DELETE /invitations/1
  # DELETE /invitations/1.xml
  def destroy
    @invitation = Invitation.find(params[:id])
    @invitation.destroy

    respond_to do |format|
      format.html { redirect_to(invitations_url) }
      format.xml  { head :ok }
    end
  end
end
