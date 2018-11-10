# frozen_string_literal: true

class UserPresenter < SimpleDelegator
  def image
    image_url || ApplicationController.helpers.asset_pack_path('images/noavatar.png')
  end
end
