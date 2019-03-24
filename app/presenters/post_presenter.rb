# frozen_string_literal: true

class PostPresenter < SimpleDelegator
  def post_comments
    comments.includes(:user)
            .order(:created_at)
            .map do |comment|
      CommentSerializer.new(comment).as_json
    end
  end
end
