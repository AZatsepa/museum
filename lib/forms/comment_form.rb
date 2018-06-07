# frozen_string_literal: true

class CommentForm < BaseForm
  attr_accessor :text,
                :post

  validates :text, :post, presence: true

  def initialize(attributes = {})
    super attributes
    @object ||= Comment.new(text: text, user: user, post: post)
    @text ||= @object.text
  end

  def update
    object.text = text
    save
  end
end
