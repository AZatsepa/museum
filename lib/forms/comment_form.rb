# frozen_string_literal: true

class CommentForm
  include ActiveModel::Model
  attr_accessor :comment, :post, :destroy_images, :text, :images
  validates :text, presence: true

  def update
    return false unless valid?

    destroy_images&.each { |id| ActiveStorage::Attachment.find(id).purge }
    comment.images.attach(images) if images
    comment.update(text: text)
  end
end
