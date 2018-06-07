# frozen_string_literal: true

class BaseForm
  include ActiveModel::Model

  delegate :attachments, to: :object

  def initialize(attributes = {})
    super attributes
  end

  def update
    raise NotImplementedError
  end

  def save
    valid? && save_object
  end

  private

  def update_attachments
    return unless attachments_attributes
    attachments_attributes.each_pair do |_k, v|
      attachments.build(v) if v[:_destroy].nil?
      destroy_attachments!(v)
    end
  end

  def destroy_attachments!(hash)
    attachments.each { |att| att.destroy if att.id == hash[:id].to_i } if destroy_attachment?(hash)
  end

  def destroy_attachment?(hash)
    hash[:_destroy] == 'on' || hash[:_destroy] == '1'
  end

  def save_object
    update_attachments
    object.save
  end
end
