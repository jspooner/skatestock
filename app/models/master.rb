class Master < ActiveRecord::Base
  
  belongs_to :proof
  belongs_to :user
  has_one :description
  
  has_attachment :content_type => :image,   # tiff or photoshop
                  :storage => :file_system, 
                  :max_size => 80000.kilobytes,
                  :thumbnails => { :thumb => '150x150>', :large => '1000x1000>' }

  validates_as_attachment 
  
  named_scope :images, :conditions => { :parent_id => nil }
  named_scope :pending_images, :conditions => { :state => "pending" }    
  named_scope :accepted_images, :conditions => { :state => "active" }    
  named_scope :active_images, :conditions => { :state => "active" }    
  named_scope :sold_images, :conditions => { :state => "sold" }    
  named_scope :this_user, lambda {|user| {:conditions => ["user_id = ?", user.id]}}
  
  acts_as_state_machine :initial => :pending, :column => 'state'
  state :pending, :after => Proc.new { puts "-------------after pending master" }
  state :active, :after => Proc.new { puts "-------------after active master" }
  state :sold, :after => Proc.new { puts "-------------after sole master" }
   
  # Mark proofs state as complete 
  def after_create
    Proof.find(self.proof_id).mark_complete! if self.proof_id
  end
  
  def after_save
    logger.info 'AFTERSAVE******************************************* '  
    puts 'AFTERSAVE******************************************* '  
    if self.thumbnail == "large"
      logger.info "found large image"
      logger.info self.public_filename(:large)
      add_watermark( self.public_filename() )
    end
    puts 'AFTERSAVE*******************************************'
    puts 'AFTERSAVE*******************************************'
    puts 'AFTERSAVE*******************************************'
    puts 'AFTERSAVE*******************************************'
  end

  def self.list(page)
    paginate :per_page => 20, :page => page
  end
  
  def self.next(current)
    images.pending_images.find(:first, :conditions =>  ['id > ?', current.id])
  end
  
  def add_watermark(file)
    logger.info "ADD WATERMARK"
    puts "ADD WATERMARK"
    puts file
    puts RAILS_ROOT
    file = RAILS_ROOT + "/public" + file
    system "composite -gravity SouthEast #{RAILS_ROOT}/public/images/watermark.png #{file} #{file}"
    puts file
  end
    
end
# States:<br/>
# Pending ( need to verify img and quality )<br/>
# Active<br/>
# Sold<br/>