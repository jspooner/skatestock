# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'db056ca471351bf7eb01b6307b5398e0'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  def admin_required
    session[:user_id] && (user = User.find(session[:user_id])) && user.is_admin
  end
  
  def authorized?
    !!session[:user_id] && (user = User.find(session[:user_id])) && (user.activated_at != nil)
  end
      
  def current_cart
    if session[:cart_id]
      @current_cart ||= Cart.find(session[:cart_id])
      session[:cart_id] = nil if @current_cart.purchased_at
    end
    if session[:cart_id].nil?
      @current_cart = Cart.create!(:user => current_user)
      session[:cart_id] = @current_cart.id
    end
    @current_cart
  end
  
  protected
  # Protect controllers with code like:
  #   before_filter :admin_required, :only => [:suspend, :unsuspend, :destroy, :purge]
  def admin_required
    current_user.respond_to?('is_admin') && current_user.send('is_admin') || access_denied
  end
  
  def check_features_using_helper( feature_id_array, feature_class, target_array )
    checked_features = []
    checked_params = feature_id_array || []
    for check_box_id in checked_params
      shoefeature = feature_class.find(check_box_id) 
      if not target_array.include?(shoefeature)
        target_array << shoefeature
      end
      checked_features << shoefeature
    end
    return checked_features
  end

  def uncheck_missing_features_helper ( features, checked_features, target_array )
    missing_features = []
    missing_features = features - checked_features
    for feature in missing_features
      if target_array.include?(feature)
       target_array.delete(feature)
      end
    end
  end
  
end
