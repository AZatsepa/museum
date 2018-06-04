class AttachmentForm
  include ActiveModel::Model

  attr_accessor :owner, :file, :attachment, :ident, :_destroy
  validates :file, presence: true, if: -> { attachment.blank? }
  validates :owner, presence: true, if: -> { attachment.blank? }

  def initialize(attributes = {})
    super attributes
    @attachment ||= Attachment.new(attachable: owner, file: file)
  end

  def save
    valid? && attachment.save
  end

  def attributes=(attributes = {})
    super attributes
    @attachment.attributes = { attachable: owner, file: file }
  end
end
