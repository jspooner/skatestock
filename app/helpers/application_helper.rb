# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def user_logged_in?
    session[:user_id]
  end
  def user_is_admin?
    session[:user_id] && (user = User.find(session[:user_id])) && user.my_group == "admin"
  end
  
  def cents_to_dollars(cents)
    cents / 100
  end
    
  def state_to_string state
    case state
    when "action_taken"
      return "Pending Review"
    when "action_needed"
      return "Edit Required"
    end
    return state
  end

end
