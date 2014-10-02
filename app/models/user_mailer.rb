class UserMailer < ActionMailer::Base
  def signup_notification(user)
    setup_email(user)
    @subject    += 'Please activate your new account'
    @body[:url]  = "#{APP_CONFIG[:domain]}/activate/#{user.activation_code}"
  end
  
  def activation(user)
    setup_email(user)
    @subject    += 'Your account has been activated!'
    @body[:url]  = "#{APP_CONFIG[:domain]}/"
  end
  
  def send_invitation(invitation)
    @recipients        = "#{invitation.email}"
    @from              = "#{APP_CONFIG[:info_email]}"
    @subject           = "[shrelp!] Sign up to sell your photos"
    @content_type      = "text/html"
    @sent_on           = Time.now
    @body[:invitation] = invitation
  end
  
  protected
    def setup_email(user)
      @recipients  = "#{user.email}"
      @from        = "#{APP_CONFIG[:info_email]}"
      @subject     = "[shrelp!] "
      @sent_on     = Time.now
      @body[:user] = user
    end
end
