class UserMailer < ActionMailer::Base
  
  default_url_options[:host] = HOST
  
  def invitation(invitation)
    from       DO_NOT_REPLY
    recipients invitation.email
    subject    "Welcome to Drapnote" 
    body       :invitation => invitation
  end

end
