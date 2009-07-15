class SearchController < ApplicationController
  def index
    if ! params[:q].blank?
      @results = Dream.search(params[:q], :page => params[:page], :per_page => 10, :include => :dreamer)
    elsif params[:q] and params[:q].blank?
      flash.now[:notice] = "Please enter a search term to continue"
    end
    
    respond_to do |wants|
      wants.html
      wants.atom
    end
    
  end
end
