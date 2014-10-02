class DashboardController < ApplicationController
  before_filter :login_required
  def index
     @action_needed = Request.this_user(current_user).find_all_by_state("action_needed")     
  end
end
