# 
# Find
# ImageShell.stock.with_riders
# 
class ImageShell < ActiveRecord::Base
  
  acts_as_state_machine :initial => :new, :column => 'state'
  state :new,           :after => Proc.new {|model|}
  state :active,        :enter => Proc.new {|model|}
  
  event :request_is_approved do
    transitions :from => :new, :to => :active
  end
  
  named_scope :this_user, lambda { |user| { :conditions => ["user_id = ?", user.id] } }
  named_scope :stock, :conditions => ["stock_id IS NOT NULL" ]          
  named_scope :editorial, :conditions => ["editorial_id IS NOT NULL" ]  
  named_scope :with_out_riders, {
    :select => "image_shells.*",
    :joins => "INNER JOIN image_shells_users ON (image_shells_users.image_shell_id!=image_shells.id)" 
  }
  named_scope :with_riders, {
    :select => "image_shells.*",
    :joins => "INNER JOIN image_shells_users ON (image_shells_users.image_shell_id=image_shells.id)" 
  }
  
      
  
  has_many :requests
  belongs_to :description
  belongs_to :user
  has_and_belongs_to_many :riders, :class_name => "User"
  has_and_belongs_to_many :invitations
  
  belongs_to :original, :class_name => "Image", :foreign_key => "original_id"
  belongs_to :editorial, :class_name => "Image", :foreign_key => "editorial_id" 
  belongs_to :stock, :class_name => "Image", :foreign_key => "stock_id"
  
  def is_available_for_private_sale
    (self.private_sale == 1) ? true : false
  end  
  
  # Returns true if action is needed
  def requires_photographer_action
    self.requests.each do |r|
      if r.state == "action_needed"
        return true
      end
    end
    false
  end
  
  # !! REMOVE !!
  # searches request and returns false if the 
  # request was denied
  def has_editorial_or_stock_for_sale
    return false if self.requests.length == 0
    self.requests.each do |r|
      return false if r.state == "denied"
    end
    true
  end  
    
end
