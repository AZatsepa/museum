require 'rails_helper'

RSpec.describe MapsController, type: :controller do
  describe 'map_1782' do
    it 'should render ' do
      expect(
        get('map_1782')
      ).to render_template('maps/1782')
    end
  end
end
