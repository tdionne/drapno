class FacebookDreamersController < ApplicationController
  before_filter :authenticate, :only => :index
  before_filter :ensure_facebook_account, :only => :index
  before_filter :ensure_accounts_linked, :only => :index
  before_filter :verify_uninstall_signature, :only => :remove
  
  def show
  end
  
  def remove
    user = User.find_by_facebook_id(params[:fb_sig_user]) 
    user.update_attribute(:facebook_id, nil) if user 
    render :nothing => true
  end
  
  protected
    def ensure_facebook_account
      redirect_to services_url unless facebook_session
    end
    
    def ensure_accounts_linked
      if facebook_session and ! current_dreamer.has_facebook_account?
        current_dreamer.update_attribute(:facebook_id, facebook_session.user.uid)
        flash.now[:notice] = 'Facebook connection established'
      end
    end
    
    def verify_uninstall_signature
      signature = ''
      facebook_params.keys.each do |key| 
        key_name = key.gsub('fb_sig_', '') 
        signature += "#{key_name}=#{params[key]}" 
      end 
      
      signature += Facebooker.secret_key
      calculated_sig = Digest::MD5.hexdigest(signature) 

      return calculated_sig == params[:fb_sig] 
    end 
    
    def post_to_stream
      dream = Dream.first
      begin
        me = Facebooker::User.new(facebook_session.user.uid)
        me.publish_to(me,
          :message => "#{current_user.name} posted a new dream #{dream.title} on Drapno",
          :action_links => {
            :text => "Read it here",
            :href => "http://localhost:3000/d/#{dream.b58}"
          }
        )
      rescue Facebooker::Session::PermissionError 
        flash.now[:error] = "I seem to be missing the stream.publish permission"
      end
    end
end
