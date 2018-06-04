class PostForm
  include ActiveModel::Model

  attr_accessor :title, :body, :attachments_attributes, :attachments, :post, :current_user
  validates :title, presence: true
  validates :body, presence: true
  validates :current_user, presence: true

  def initialize(attributes = {})
    super attributes
    @post = Post.new(title: title, body: body, user: current_user)
    @attachments = [AttachmentForm.new]
    return if attachments_attributes.blank?
    update_attachments
  end

  def save
    valid? && post.save && attachments.each(&:save)
  end

  private

  def update_attachments
    attachments_attributes.each_pair do |k, v|
      attributes_hash = v.merge(owner: post)
      if attachments[k.to_i].present?
        attachments[k.to_i].attributes = attributes_hash
      else
        attachments << AttachmentForm.new(attributes_hash)
      end
    end
  end
end
