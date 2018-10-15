# frozen_string_literal: true

PostPresenter = Struct.new(:post) do
  delegate :id, :title, :body, :attachments, to: :post

  def html_body
    body.html_safe
  end

  def comments
    post.comments.includes(:user, :attachments).order(:created_at).map do |comment|
      CommentSerializer.new(comment).as_json
    end
  end
end
