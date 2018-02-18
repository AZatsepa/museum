require 'rails_helper'

RSpec.describe ComparisonController, type: :controller do
  describe '_1782_1943' do
    it 'should render template comparison/1782_1943' do
      expect(
        get('_1782_1943')
      ).to render_template('comparison/1782_1943')
    end
  end

  describe '_1943_2017' do
    it 'should render template comparison/1943_2017' do
      expect(
        get('_1943_2017')
      ).to render_template('comparison/1943_2017')
    end
  end

  describe '_1782_2017' do
    it 'should render template comparison/1782_2017' do
      expect(
        get('_1782_2017')
      ).to render_template('comparison/1782_2017')
    end
  end
end
