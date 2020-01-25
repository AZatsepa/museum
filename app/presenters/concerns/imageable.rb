# frozen_string_literal: true

module Imageable
  include ActiveSupport::Concern

  def img_url
    return attached_image_url if image.attached?

    ApplicationController.helpers.asset_pack_path('media/images/noavatar.png')
  end

  private

  def attached_image_url
    Rails.env.production? ? image.attachment.service_url : rails_blob_path(image)
  end
end
