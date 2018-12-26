# frozen_string_literal: true

class PostForm
  include ActiveModel::Model
  attr_accessor :post, :user, :destroy_images, :title, :body, :images
  validates :title, presence: true
  validates :body, presence: true

  def update
    return false unless valid?

    destroy_images&.each { |id| ActiveStorage::Attachment.find(id).purge }
    post.images.attach(images) if images
    post.update(title: title, body: body)
  end
end
