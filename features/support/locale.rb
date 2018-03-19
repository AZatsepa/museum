class ActionView::TestCase::TestController
  def default_url_options(_options = {})
    { locale: :en }
  end
end

class ActionDispatch::Routing::RouteSet
  def default_url_options(_options = {})
    { locale: :en }
  end
end
