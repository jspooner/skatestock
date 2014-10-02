class UsersController < ApplicationController
  
  # Protect these actions behind an admin login
  before_filter :admin_required, :only => [:suspend, :unsuspend, :destroy, :purge, :index]
  # before_filter :find_user, :only => [:suspend, :unsuspend, :destroy, :purge]
  # before_filter :login_required  
  
  def index
    @users = User.find(:all)
  end

  # render new.rhtml
  def new
    @user = User.new
    if params[:id] == "photographer" || params[:id] == "rider" || params[:id] == "consumer"
      @user.my_group = params[:id] 
    else
      @user.my_group = "select"
    end
  end

  def create
    cookies.delete :auth_token
    # protects against session fixation attacks, wreaks havoc with 
    # request forgery protection.
    # uncomment at your own risk
    # reset_session
    @user = User.new(params[:user])
    # @user.login = @user.email
    puts "@user.agreed " + @user.agreed.to_s
    puts "@user.agreed_to_model_release " + @user.agreed_to_model_release.to_s
    if params[:user][:my_group] == "admin"
      group = "badperson"
      redirect("http://google.com")
    else
      group = params[:user][:my_group]
    end
    @user.my_group = group
    
    @user.register! if @user.valid?
    if @user.errors.empty?
      self.current_user = @user
      redirect_back_or_default('/login')
      flash[:notice] = "Thanks for signing up! Check your email to authenicate your account."
    else
      @group = @user.my_group
      render :action => 'new'
    end
  end
  
  def show
    @user = User.find(params[:id], :include => [:image_shells])
  end

  def activate
    self.current_user = params[:activation_code].blank? ? false : User.find_by_activation_code(params[:activation_code])
    if logged_in? && !current_user.active?
      current_user.activate!
      flash[:notice] = "Your account has been activated!"
    end
    redirect_to dashboard_path
  end

  def suspend
    @user.suspend! 
    redirect_to users_path
  end

  def unsuspend
    @user.unsuspend! 
    redirect_to users_path
  end

  def destroy
    @user.delete!
    redirect_to users_path
  end

  def purge
    @user.destroy
    redirect_to users_path
  end

protected
  def find_user
    @user = User.find(params[:id])
  end

end
