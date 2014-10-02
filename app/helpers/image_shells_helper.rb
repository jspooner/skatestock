module ImageShellsHelper
  
  def image_shell_state requests
    str = requests.collect { |r| "#{r.request_type} #{r.state}, "} 
    
    case str.to_s
    when "stock new, editorial new, "
      return "Pending"
    when "stock action_needed, editorial new, "
      return "Modification Requested"
    when "stock action_taken, editorial new, "
       return "Pending"
    when "stock new, editorial approved, "
      return "Editorial - Pending Stock"
    when "stock approved, editorial new, "  
      return "Stock - Pending Editorial"
    when "stock approved, editorial approved, "
      return "Approved"
    end
    
    return str
  end
end
