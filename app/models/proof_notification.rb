class ProofNotification < ActionMailer::Base
  
  def approved(name, email)
      @recipients   = "#{email}"
      @from         = APP_CONFIG[:info_email]
      headers         "Reply-to" => APP_CONFIG[:info_email]
      @subject      = "Your Proof was accepted"
      @sent_on      = Time.now
      @content_type = "text/html"

      body[:name]  = name
      body[:email] = email       
    end

end
