module ErrorRenderers
  def render_500
    respond_to do |type|
      type.html { render :file => "#{RAILS_ROOT}/public/500.html", :status => "500 Error" }
      type.all  { render :nothing => true, :status => "500 Error" }
    end
  end

  def render_401
    respond_to do |type|
      type.html { render :file => "#{RAILS_ROOT}/public/401.html", :status => "403 Unauthorized" }
      type.all  { render :nothing => true, :status => "401 Unauthorized" }
    end
  end
    
  def render_403
    respond_to do |type|
      type.html { render :file => "#{RAILS_ROOT}/public/403.html", :status => "403 Forbidden" }
      type.all  { render :nothing => true, :status => "403 Forbidden" }
    end
  end
  
  def render_404
    respond_to do |type|
      type.html { render :file => "#{RAILS_ROOT}/public/404.html", :status => "404 Not Found" }
      type.all  { render :nothing => true, :status => "404 Not Found" }
    end
  end
  
  def render_405
    respond_to do |type|
      type.html { render :file => "#{RAILS_ROOT}/public/403.html", :status => "405 Method Not Allowed" }
      type.all  { render :nothing => true, :status => "405 Method Not Allowed" }
    end
  end
end