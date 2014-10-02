class WelcomeController < ApplicationController

  def index
    if current_user  
      if current_user.login == "admin"
        @num_proofs = Proof.count(:all, :conditions => { :state => "pending" } ).to_s
        @num_userss = User.count(:all, :conditions => { :state => "pending" } ).to_s
      elsif current_user.login == "photographer"
     
      elsif current_user.login == "consumer"
        
      end
    end
  end

end
