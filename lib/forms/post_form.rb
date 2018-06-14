# frozen_string_literal: true

class PostForm < BaseForm
  attr_accessor :title,
                :body
  validates :title, :body, presence: true

  def initialize(attributes = {})
    super attributes
    @title ||= model.title
    @body ||= model.body
  end

  def update
    model.title = title
    model.body = body
    save
  end

  def model
    @model ||= Post.new(title: title, body: body, user: user)
  end
end
