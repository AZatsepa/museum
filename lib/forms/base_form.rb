# frozen_string_literal: true

class BaseForm
  include ActiveModel::Model
  attr_accessor :attachments,
                :user
  attr_writer :model
  attr_reader :attachments_attributes

  validates :user, presence: true

  def initialize(attributes = {})
    super attributes
    @attachments = @attachments || @model&.attachments || []
  end

  def attachments_attributes=(attributes)
    @attachments = @attachments || @model&.attachments || []
    @attachments_attributes = attributes
    @attachments_attributes.each do |_i, attachment_params|
      next if attachment_params[:file].blank?
      @attachments.push(Attachment.new(attachable: @model, file: attachment_params[:file]))
    end
  end

  def update
    raise NotImplementedError
  end

  def save
    valid? && save_model
  end

  private

  def update_attachments
    attachments.each do |attachment|
      attachment.attachable = model
      attachment.save
    end
    destroy_attachments!
  end

  def destroy_attachments!
    return if attachments_attributes.blank?
    ids = []
    attachments_attributes.each_value do |v|
      ids << v[:id] if %w[on 1].include?(v[:_destroy])
    end
    model.attachments.where(id: ids).destroy_all
  end

  def save_model
    return false unless model.save
    update_attachments
    true
  end
end
