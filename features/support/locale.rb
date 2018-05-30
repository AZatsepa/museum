# frozen_string_literal: true

module ActionView
  class TestCase::TestController
    def default_url_options(_options = {})
      { locale: :en }
    end
  end
end

module ActionDispatch
  module Routing
    class RouteSet
      def default_url_options(_options = {})
        { locale: :en }
      end
    end
  end
end
