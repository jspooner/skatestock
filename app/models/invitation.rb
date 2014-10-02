class Invitation < ActiveRecord::Base
  has_and_belongs_to_many :image_shells
  has_and_belongs_to_many :users
  
  
  def before_create()
    self.permalink = "--#{self.first_name}--#{self.last_name}--".crypt("shrelp")
    # self.permalink = Digest::SHA1.hexdigest("--#{self.first_name}--#{self.last_name}--")
  end
  def after_save()
    if not self.email.nil?
      UserMailer.deliver_send_invitation(self)
    end
  end
end
