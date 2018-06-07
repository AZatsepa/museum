# frozen_string_literal: true

class BaseForm
  include ActiveModel::Model
  attr_accessor :attachments,
                :object,
                :user
  attr_reader :attachments_attributes

  validates :user, presence: true

  def initialize(attributes = {})
    super attributes
    @attachments = @attachments || @object&.attachments || []
  end

  def attachments_attributes=(attributes)
    @attachments = @attachments || @object&.attachments || []
    @attachments_attributes = attributes
    @attachments_attributes.each do |_i, attachment_params|
      next if attachment_params[:file].blank?
      @attachments.push(Attachment.new(attachable: @object, file: attachment_params[:file]))
    end
  end

  def update
    raise NotImplementedError
  end

  def save
    valid? && save_object
  end

  private

  def update_attachments
    attachments.each do |attachment|
      attachment.attachable = object
      attachment.save
    end
    destroy_attachments!
  end

  def destroy_attachments!
    return if attachments_attributes.blank?
    attachments_attributes.each do |_i, hash|
      object.attachments.each { |att| att.destroy if att.id == hash[:id].to_i } if destroy_attachment?(hash)
    end
  end

  def destroy_attachment?(hash)
    %w[on 1].include?(hash[:_destroy])
  end

  def save_object
    return false unless object.save
    update_attachments
    true
  end
end
