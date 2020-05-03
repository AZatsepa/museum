# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MapsController, type: :controller do
  describe 'map_1782' do
    it 'renders template' do
      expect(
        get('map_1782')
      ).to render_template('maps/map_1782')
    end
  end
end
