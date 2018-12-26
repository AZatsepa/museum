# frozen_string_literal: true

class ImageSerializer < ActiveModel::Serializer
  attributes :id, :url, :filename

  def filename
    object.blob.filename.to_s
  end

  def url
    Rails.application.routes.url_helpers.rails_blob_path(object, only_path: true)
  end
end
