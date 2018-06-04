class CommentForm
  include ActiveModel::Model

  attr_accessor :text,
                :attachments_attributes,
                :attachments,
                :post,
                :current_user,
                :comment,
                :attachments

  validates :text, presence: true
  delegate :attachments, to: :comment

  def initialize(attributes = {})
    super attributes
    @comment ||= Comment.new(text: text, user: current_user, post: post)
    attachments.build
  end

  def update
    comment.text = text
    save
  end

  def save
    attachments.each { |attachment| attachments.destroy(attachment) if attachment.file.file.nil? }
    valid? && save_comment
  end

  private

  def update_attachments
    return unless attachments_attributes
    attachments_attributes.each_pair do |k, v|
      attachments.build(v) if v[:_destroy].blank?
      destroy_attachments!(v)
    end
  end

  def destroy_attachments!(hash)
    attachments.each { |att| att.destroy if att.id == hash[:id].to_i } if hash[:_destroy] == '1'
  end

  def save_comment
    update_attachments
    comment.save
  end
end
