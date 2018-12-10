# frozen_string_literal: true

class PostPresenter < SimpleDelegator
  def html_body
    body.html_safe
  end

  def post_comments
    comments.includes(:user, :attachments).order(:created_at).map do |comment|
      CommentSerializer.new(comment).as_json
    end
  end
end
