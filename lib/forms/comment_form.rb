# frozen_string_literal: true

class CommentForm < BaseForm
  attr_accessor :text,
                :attachments_attributes,
                :post,
                :current_user,
                :object

  validates :text, presence: true

  def initialize(attributes = {})
    super attributes
    @object ||= Comment.new(text: text, user: current_user, post: post)
    @text ||= @object.text
  end

  def update
    object.text = text
    save
  end
end
