# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Clearance::Authentication
  include ErrorRenderers
  include InvitationSystem
  include ExceptionNotifiable

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password
  before_filter :transfer_dreamer_params
  skip_before_filter :verify_authenticity_token, :if => proc { |c| c.request.js? }
      
  protected
    def restrict_to_admin
      unless signed_in? and current_user.is_admin?
        render_401 and return false
      end
    end
    
  private
  
    # Making clearance work with a user called anything but User (in our case Dreamer)
    # is a bit of a pain. This is a bit of a hack to make it simpler.
    def transfer_dreamer_params
      params[:user_id] ||= params[:dreamer_id]
      params[:user] ||= params[:dreamer]
    end
    
    def sign_user_in(user)
      # store current time to display "last signed in at" message
      user.update_attribute(:last_signed_in_at, Time.now)
      sign_in(user)
    end
end
