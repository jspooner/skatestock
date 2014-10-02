class RequestsController < ApplicationController
  
  before_filter :admin_required  
  
  def index
    if params[:image_shell_id]
      @image_shell = ImageShell.find(params[:image_shell_id], :include => [:requests, :images])
      if @image_shell.requires_photographer_action
        render :template => "requests/index_photographer"
      else
        render :text => "nothing"
      end
    else
      # move to named_scopeA
      @new_stock_requests           = Request.find(:all, :conditions => { :state => "new", :request_type => "stock" }, :include => [:image_shell, :user] )
      @responded_stock_requests     = Request.find(:all, :conditions => { :state => "action_taken", :request_type => "stock" }, :include => [:image_shell, :user]  ) 
      @action_stock_requests        = Request.find(:all, :conditions => { :state => "action_needed", :request_type => "stock" }, :include => [:image_shell, :user]  ) 
      @denied_stock_requests        = Request.find(:all, :conditions => { :state => "denied", :request_type => "stock" }, :include => [:image_shell, :user]  ) 
      
      @new_editorial_requests       = Request.find(:all, :conditions => { :state => "new", :request_type => "editorial" }, :include => [:image_shell, :user] )
      @responded_editorial_requests = Request.find(:all, :conditions => { :state => "action_taken", :request_type => "editorial" }, :include => [:image_shell, :user]  )      
      @action_editorial_requests    = Request.find(:all, :conditions => { :state => "action_needed", :request_type => "editorial" }, :include => [:image_shell, :user]  )      
      @denied_editorial_requests    = Request.find(:all, :conditions => { :state => "denied", :request_type => "editorial" }, :include => [:image_shell, :user]  )      
    end
  end
  
  def show
    @request = Request.find(params[:id])
  end
  
  def new
    @request = Request.new(:image_id => params[:image_id])
  end
  
  def create
    @request = Request.new(params[:request])
    if @request.save
      flash[:notice] = "Successfully created request."
      redirect_to @request.image
    else
      render :action => 'new'
    end
  end
  
  def edit
    @request = Request.find(params[:id])
  end
  # 
  # 2. Update the state of the image_shell to match the request... to avoid
  def update
    @request = Request.find(params[:id])
    
    @request.request_action!      if params[:request][:state] == "action_needed"
    @request.request_denied!      if params[:request][:state] == "denied"
    @request.request_approved!    if params[:request][:state] == "approved"
    @request.state = "new"        if params[:request][:state] == "new"      # use fsm method so it will send an email
    
    @request.image_shell.update_attributes(:requires_release => params[:image_shell][:requires_release]) if params[:image_shell][:requires_release]

    if @request.state == "approved" 
      if @request.request_type == "stock"
        @request.image_shell.stock = @request.original_image
        @request.image_shell.stock = @request.updated_image || @request.original_image        
        @request.image_shell.save  
      elsif @request.request_type == "editorial"
        @request.image_shell.editorial = @request.original_image
        @request.image_shell.editorial = @request.updated_image || @request.original_image        
        @request.image_shell.save
      end
    end
                    
    if @request.update_attributes(params[:request])
      flash[:notice] = "Successfully updated request."
      redirect_to requests_path
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @request = Request.find(params[:id])
    @request.destroy
    flash[:notice] = "Successfully destroyed request."
    redirect_to requests_url
  end
  
  
  
  
 
end
