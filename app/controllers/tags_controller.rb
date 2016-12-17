class TagsController < ApplicationController
  def show
    @tag = ActsAsTaggableOn::Tag.first(:conditions => ['id = ? OR name = ?', params[:id], params[:id]])
    raise ActiveRecord::RecordNotFound unless @tag
    
    @dreams = Dream.tagged_with(@tag.name, {}).paginate(:page => params[:page], :per_page => 20)
    
    respond_to do |format|
      format.html
      format.json { render :json => @dreams }
    end
  end
end
