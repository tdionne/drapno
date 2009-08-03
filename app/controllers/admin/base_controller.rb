class Admin::BaseController < ApplicationController
  before_filter :ensure_admin
  layout 'admin'
  
  protected
    def ensure_admin
      if ! signed_in?
        deny_access
      elsif ! current_user.is_admin?
        render_401 and return
      end
    end
end
