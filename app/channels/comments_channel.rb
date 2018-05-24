class CommentsChannel < ApplicationCable::Channel
  def follow
    stream_from "comments_for_post_#{params[:post_id]}"
  end
end
