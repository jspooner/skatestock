# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController

  # render new.rhtml
  def new
  end

  def create
    self.current_user = User.authenticate(params[:login], params[:password])
    
    puts "//////////////////    LOGGED " + logged_in?.to_s
    
    if logged_in? && authorized?
      if params[:remember_me] == "1"
        current_user.remember_me unless current_user.remember_token?
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      end
      
      puts '////////////////////////   dashboard_path' + dashboard_path.to_s
      
      redirect_to dashboard_path
      flash[:notice] = "Logged in successfully"
    else
      flash[:notice] = (authorized?) ? "Username or password was incorrect" : "Please chck your email for authorization code."
      render :action => 'new'
    end
  end

  def destroy
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_back_or_default('/')
  end
end
