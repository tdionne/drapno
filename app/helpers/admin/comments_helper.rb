module Admin::CommentsHelper
  def comment_list_title
    unless params[:filter].blank?
      "Listing comments with status <em>#{params[:filter].capitalize}</em>"
    else
      "Listing comments"
    end
  end
end
