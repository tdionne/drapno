class UserMailer < ActionMailer::Base
  
  default_url_options[:host] = HOST
  
  def comment(comment)
    from       DO_NOT_REPLY
    recipients comment.dream.dreamer.email
    subject    "Someone commented on your dream"
    body       :comment => comment
  end
  
  def appearance(appearance)
    from       DO_NOT_REPLY
    recipients appearance.email
    subject    "You appeared in a dream"
    body       :appearance => appearance
  end
  
  def invitation(invitation)
    from       DO_NOT_REPLY
    recipients invitation.email
    subject    "Welcome to Drapno" 
    body       :invitation => invitation
  end

end
