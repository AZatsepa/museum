# frozen_string_literal: true

class CommentForm < BaseForm
  attr_accessor :text,
                :post

  validates :text, :post, presence: true

  def initialize(attributes = {})
    super attributes
    @text ||= model.text
  end

  def update
    model.text = text
    save
  end

  def model
    @model ||= Comment.new(text: text, user: user, post: post)
  end
end
