class TagsController < ApplicationController
  def show
    @tag = Tag.first(:conditions => ['id = ? OR name = ?', params[:id], params[:id]])
    @dreams = Dream.listings.tagged_with(@tag.name, {}).paginate(:page => params[:page], :per_page => 20)
  end
end
