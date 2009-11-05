module DreamsHelper
  def eligible_to_comment_on?(dream)
    dream.dreamer != current_user or dream.comments_count > 0
  end
end
