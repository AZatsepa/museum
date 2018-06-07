# frozen_string_literal: true

class PostForm < BaseForm
  attr_accessor :title,
                :body
  validates :title, :body, :current_user, presence: true

  def initialize(attributes = {})
    super attributes
    @object ||= Post.new(title: title, body: body, user: current_user)
    @title ||= @object.title
    @body ||= @object.body
  end

  def update
    object.title = title
    object.body = body
    save
  end
end
