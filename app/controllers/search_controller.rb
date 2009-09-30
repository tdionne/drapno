class SearchController < ApplicationController
  def index
    load_tags
    @levels = (1..5).map { |i| "level-#{i}" }
    
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
  
  protected
    def load_tags
      @tags = Tag.find(:all,
        :select => "#{Tag.table_name}.id, #{Tag.table_name}.name, COUNT(*) AS count",
        :joins  => "LEFT OUTER JOIN #{Tagging.table_name} ON #{Tag.table_name}.id = #{Tagging.table_name}.tag_id",
        :group  => "#{Tag.table_name}.id, #{Tag.table_name}.name HAVING COUNT(*)> 0",
        :order  => "count DESC",
        :limit  => 30
      ).sort_by(&:name)
    end
end
