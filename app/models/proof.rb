class Proof < ActiveRecord::Base
  
  belongs_to :user
  has_one :master
  has_one :description
  
  has_attachment :content_type => :image,     # exclude gif
                  :storage => :file_system, 
                  :max_size => 80000.kilobytes,
                  :resize_to => '1500x1500>',
                  :thumbnails => { :thumb => '150x150>' }

   validates_as_attachment
  
   named_scope :images, :conditions => { :parent_id => nil }
   named_scope :pending_images, :conditions => { :state => "pending" }    
   named_scope :accepted_images, :conditions => { :state => "approved" }    
   named_scope :complete_images, :conditions => { :state => "complete" }    
   named_scope :this_user, lambda {|user| {:conditions => ["user_id = ?", user.id]}}
   
   acts_as_state_machine :initial => :private, :column => 'state'
   state :private, :after => Proc.new { puts "-------------after Private" }
   state :pending, :after => Proc.new { puts "-------------after Pending" }
   state :approved, :after => Proc.new { 
     ProofNotification.deliver_approved("SpoonMan", "info@shrelp.comlp.com")
   }
   state :complete, :after => Proc.new { puts "-------------after COMPLETED" }
   
   event :approve_image do
      puts 'approve_image'
      transitions :from => :pending, :to => :approved
   end
   
   event :mark_pending do
      puts 'mark_pending'
      transitions :from => :approved, :to => :pending      
   end
   
   event :mark_complete do
      puts "mark_complete"
      transitions :from => :approved, :to => :complete
   end
   
   def self.list(page)
     paginate :per_page => 20, :page => page
   end
   
   def self.next(current)
     images.pending_images.find(:first, :conditions =>  ['id > ?', current.id])
   end
   
end



