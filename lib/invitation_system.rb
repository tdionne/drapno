module InvitationSystem
  EXCLUSION_LIST = %W(DreamersController Clearance::SessionsController Clearance::ConfirmationsController Clearance::PasswordsController)
  
  def invitation_only_authenticate
    authenticate
  end

  def limited_to_invitation_only?
    invitation_only? and ! in_exceptions_list?
  end

  def in_exceptions_list?
    EXCLUSION_LIST.include?(self.class.to_s)
  end

  def validate_invitation
    @invitation = Invitation.redeemable.find_by_invitation_code!(params[:code])
  end  
  
  def invitation_only?
    defined?(::INVITATION_ONLY) == 'constant' ? ::INVITATION_ONLY : false
  end
  
  
  def self.included(klass)
    klass.helper_method :invitation_only?
    klass.before_filter :invitation_only_authenticate, :if => :limited_to_invitation_only?
  end
end