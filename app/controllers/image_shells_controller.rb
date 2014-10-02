class ImageShellsController < ApplicationController
  
  before_filter :login_required
  
  def index
    if current_user.is_admin    
      @image_shells = ImageShell.find(:all, :include => [:requests,:original,:description])
    else
      @image_shells = ImageShell.this_user(current_user).find(:all, :include => [:requests,:original,:description])
    end
  end
  
  def show
    @image_shell       = ImageShell.find(params[:id])
    @editorial_request = @image_shell.requests.find_by_request_type("editorial")
    @stock_request     = @image_shell.requests.find_by_request_type("stock")
    
    if current_user.my_group == "consumer"
      if @image_shell.is_available_for_private_sale
        render :template => "/image_shells/_show_consumer"  
      else
        redirect_to '/'
      end
    end
    
  end
  
  def new
    @image_shell       = ImageShell.new
    @image_shell.user  = current_user  
    @riders            = User.riders.find :all
  end
  
  def create
    @image_shell             = ImageShell.new(params[:image_shell])
    @image_shell.description = Description.new(params[:description])
    @image_shell.original    = Image.new(params[:original]) 
    @image_shell.original.save
    
    create_request()
    has_new_invite = manage_riders_and_invitations(params,@image_shell)

    if @image_shell.save  
      flash[:notice] = "Successfully created image."
      if has_new_invite
        redirect_to "/users/#{current_user.id}/invitations/edit_multiple?i=#{@image_shell.id}&ids=#{(@image_shell.invitations.collect {|r| r.permalink }).join(",")}"
      else
        redirect_to image_shells_path 
      end
    else
      render :action => 'new'
    end
  end
  
  def edit
    @riders            = User.riders.find :all
    @image_shell       = ImageShell.find(params[:id])
    @editorial_request = @image_shell.requests.find_by_request_type("editorial")
    @stock_request     = @image_shell.requests.find_by_request_type("stock")
  end
  
  def update
    @image_shell = ImageShell.find(params[:id])
    # Save rider
    has_new_invite = manage_riders_and_invitations(params,@image_shell)
    # Save Images
    if params[:stock] && params[:stock][:image] != ""
      @image_shell.stock.destroy if @image_shell.stock
      newimage                    = Image.new(params[:stock]) 
      stock_request               = @image_shell.requests.find_by_request_type("stock")
      stock_request.action_was_taken!
      stock_request.updated_image = newimage
      stock_request.save
    end
    
    if params[:editorial] && params[:editorial][:image] != ""
     @image_shell.editorial.destroy   if @image_shell.editorial
      newimage                        = Image.new(params[:editorial]) 
      editorial_request               = @image_shell.requests.find_by_request_type("editorial")
      editorial_request.action_was_taken!
      editorial_request.updated_image = newimage
      editorial_request.save
    end
        
    if @image_shell.update_attributes(params[:image_shell]) && @image_shell.description.update_attributes(params[:description])
      flash[:notice] = "Successfully updated image."
      if has_new_invite
        redirect_to "/users/#{current_user.id}/invitations/edit_multiple?i=#{@image_shell.id}&ids=#{(@image_shell.invitations.collect {|r| r.permalink }).join(",")}"
      else
        redirect_to @image_shell         
      end
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @image_shell = ImageShell.find(params[:id])
    @image_shell.destroy
    flash[:notice] = "Successfully destroyed imageshell."
    redirect_to image_shells_url
  end
  
  private
  
  def create_request 
    # create Request for stock
    sr                = Request.new(:request_type => "stock")      
    sr.original_image = @image_shell.original
    sr.user           = current_user
    @image_shell.requests << sr
    # create Request for editorial          
    r                = Request.new(:request_type => "editorial")      
    r.original_image = @image_shell.original
    r.user           = current_user
    @image_shell.requests << r
  end
  
  def manage_riders_and_invitations(params, image_shell)
    if params[:riders][:riders]
      new_p_list         = params[:riders][:riders].split(",").each { |r| r.strip! }.uniq
      new_p_list.concat( params[:riders][:ridersnames].split(",").each { |r| r.strip! } )
      new_list           = Array.new
      delete_list        = Array.new
      new_invite_list    = Array.new
      delete_invite_list = Array.new
      puts "/////////////////////////////////////////////////////// new_p_list  #{new_p_list}"
      new_p_list.each do |t|
        fn    = t.split(" ")[0]
        ln    = t.split(" ")[1]
        temp = User.riders.find(:first, :conditions => ["first_name='#{fn}' AND last_name='#{ln}'"])
        if temp
          puts "///////////////// found rider #{temp.first_name} #{temp.last_name}"
          new_list << temp
          if not image_shell.riders.include?(temp)
            image_shell.riders << temp              
          end
        else
          puts "///////////////// invitation #{fn} #{ln}"
          invite = Invitation.find_or_create_by_first_name_and_last_name(fn,ln)
          if invite
            new_invite_list << invite
            if not image_shell.invitations.include?(invite)
              image_shell.invitations << invite
              image_shell.user.invitations << invite
            end
          end
          puts "///////////////// invite #{invite}"
        end
      end
      puts "/////////////////////////////////////////////////////// new_list  #{new_list.collect{|t| t.first_name + ' ' + t.last_name}}"
      puts "/////////////////////////////////////////////////////// COMPLETE LIST  #{image_shell.riders.collect{|t| t.first_name + ' ' + t.last_name} }"
      delete_list = image_shell.riders - new_list
      delete_invite_list = image_shell.invitations - new_invite_list
      puts "/////////////////////////////////////////////////////// DELETE LIST  #{delete_list.collect{|t| t.first_name + ' ' + t.last_name}}"
      puts "/////////////////////////////////////////////////////// new_invite_list  #{new_invite_list.collect{|t| t.first_name + ' ' + t.last_name}}"
      puts "/////////////////////////////////////////////////////// delete_invite_list  #{delete_invite_list.collect{|t| t.first_name + ' ' + t.last_name}}"
      delete_list.each { |r| image_shell.riders.delete(r) }
      delete_invite_list.each { |r| image_shell.invitations.delete(r) }
      # return boolean
      (new_invite_list.length > 0)
    end
  end
  
end
