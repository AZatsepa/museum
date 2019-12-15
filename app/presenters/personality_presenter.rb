# frozen_string_literal: true

class PersonalityPresenter < BasePresenter
  def img_url
    if image.attached?
      rails_blob_path(image)
    else
      ApplicationController.helpers.asset_pack_path('media/images/noavatar.png')
    end
  end
end
