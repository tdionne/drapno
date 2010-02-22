class FacebookDreamersController < ApplicationController
  def index
    if current_user and facebook_session
      current_user.update_attribute(:facebook_id, facebook_session.user.uid)
      flash.now[:notice] = 'Facebook connection established'
    end
  end
  
  protected
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
