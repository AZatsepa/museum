class AttachmentSerializer < ActiveModel::Serializer
  attributes :id, :url, :filename

  def filename
    object.file.file.filename
  end

  def url
    object.file.url
  end
end
