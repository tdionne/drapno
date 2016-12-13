# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
require 'clearance/authentication'

class ApplicationController < ActionController::Base
  include Clearance::Controller
  include Clearance::Authentication
  # include ErrorRenderers
  # include InvitationSystem

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # before_filter :set_facebook_session
  # helper_method :facebook_session
  
  before_filter :transfer_dreamer_params
  skip_before_filter :verify_authenticity_token, :if => proc { |c| c.request.xhr? }
  
  alias :current_dreamer :current_user
  helper_method :current_dreamer

  rescue_from ActionController::MethodNotAllowed, :with => :render_406

  def load_tags
    @tags = Tag.all(
      :select => "#{Tag.table_name}.id, #{Tag.table_name}.name, COUNT(*) AS count",
      :joins  => "LEFT OUTER JOIN #{Tagging.table_name} ON #{Tag.table_name}.id = #{Tagging.table_name}.tag_id",
      :group  => "#{Tag.table_name}.id, #{Tag.table_name}.name HAVING COUNT(*)> 0",
      :order  => "count DESC",
      :limit  => 30
    ).sort_by(&:name)
    @levels = (1..5).map { |i| "level-#{i}" }
  end
  
  protected
    def restrict_to_admin
      unless signed_in? and current_user.is_admin?
        render_401 and return false
      end
    end
    
    def http_authenticate
      authenticate_or_request_with_http_basic("Drapno") do |email, password|
        @_current_user ||= User.authenticate(email, password)
      end
    end
      
    def deny_access(flash_message = nil, opts = {})
      if request.format.atom?
        render_401
      else
        store_location
        flash[:failure] = flash_message if flash_message
        redirect_to('/sign_in')
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
