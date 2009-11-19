class HomeController < ApplicationController
  def index
    load_tags
    @recent_dreams = Dream.listings.all(:limit => 5)
  end
  
  def page
    @page = Page.find_by_permalink(params[:permalink])
  end
end
