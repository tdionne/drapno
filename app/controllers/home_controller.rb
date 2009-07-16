class HomeController < ApplicationController
  def index
    @recent_dreams = Dream.listings.all(:limit => 10)
  end
end
