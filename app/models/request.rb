class Request < ActiveRecord::Base
  # belongs_to :image
  belongs_to :image_shell
  belongs_to :updated_image, :class_name => "Image", :foreign_key => "updated_image_id"
  belongs_to :original_image, :class_name => "Image", :foreign_key => "image_id"
  belongs_to :user
  
  validates_presence_of :request_type, :on => :create, :message => "can't be blank"
  
  named_scope :this_user, lambda { |user| { :conditions => ["user_id = ?", user.id] } }
  
  acts_as_state_machine :initial => :new, :column => 'state'
  
  state :new,           :after => Proc.new {|model| 
    model.update_image_state
    # ProofNotification.deliver_approved("SpoonMan new", "info@shrelp.com@gmail.com") 
  } 
  state :action_needed, :after => Proc.new {|model| 
    model.update_image_state
    ProofNotification.deliver_approved("SpoonMan action needed", "info@shrelp.com@gmail.com") 
  } 
  state :action_taken,  :after => Proc.new {|model| 
    model.update_image_state
    # ProofNotification.deliver_approved("Action TAKEN!!!!!!", "info@shrelp.com@gmail.com") 
  } 
  state :approved, :after => Proc.new {|model|
    model.update_image_state
    puts "///////////  self.image_shell.state_approved! "
    model.image_shell.request_is_approved!
    ProofNotification.deliver_approved("SpoonMan approved", "info@shrelp.com@gmail.com") 
  } 
  state :denied, :after => Proc.new {|model| 
    model.update_image_state
    ProofNotification.deliver_approved("SpoonMan denied", "info@shrelp.com@gmail.com") 
  }
  
  event :request_action do
    transitions :from => :new, :to => :action_needed
    transitions :from => :action_needed, :to => :action_needed
    transitions :from => :action_taken, :to => :action_needed    
  end
  
  event :request_denied do
    transitions :from => :new, :to => :denied
    transitions :from => :action_needed, :to => :denied
  end

  event :request_approved do
    transitions :from => :new,            :to => :approved
    transitions :from => :action_needed,  :to => :approved
    transitions :from => :action_taken,   :to => :approved
  end
  
  event :action_was_taken do
    transitions :from => :action_needed, :to => :action_taken
  end
  
  def update_image_state
    # if original_image
    #      original_image.state = self.state
    #      original_image.save      
    #    end
    # 
    #    if updated_image
    #      updated_image.state = self.state
    #      updated_image.save      
    #    end
    
  end
  
end