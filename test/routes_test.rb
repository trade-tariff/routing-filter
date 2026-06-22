require 'test_helper'

class RoutesTest < Minitest::Test
  include RoutingFilter
  class RoutingFilter::Test < Filter
    def around_recognize(path, env, &block)
      'recognized'
    end

    def around_generate(*args, &block)
      yield.tap do |result|
        result.update 'generated'
      end
    end
  end

  class RoutingFilter::NamedHelperLocale < Filter
    def around_generate(params, &block)
      locale = params.delete(:locale)

      yield.tap do |result|
        result.update "/#{locale}#{result.url}" if locale
      end
    end
  end

  class RoutingFilter::RecognitionMarker < Filter
    def around_recognize(path, env, &block)
      path.sub!(%r{^/marker}, '')

      yield.tap do |params|
        params[:marker] = 'yes'
      end
    end
  end

  attr_reader :routes

  def setup
    @routes = draw_routes do
      filter :test
      get 'some/:id', :to => 'some#show'
    end
  end

  test "routes.filter instantiates and registers a filter" do
    assert routes.filters.first.is_a?(RoutingFilter::Test)
  end

  # test "filter.around_recognize is being called" do
  #   assert_equal 'recognized', routes.recognize_path('/')
  # end

  test "filter.around_generate is being called" do
    assert_equal 'generated', routes.path_for({ controller: 'some', action: 'show', id: 1 })
  end

  test "filter.around_generate is called for named route helpers" do
    routes = draw_routes do
      filter :named_helper_locale
      get 'some', :to => 'some#show', :as => :some
    end

    assert_equal '/de/some', routes.url_helpers.some_path(locale: 'de')
  end

  test "route set generate override accepts the current Rails signature" do
    assert_equal(
      [[:req, :route_key], [:req, :options], [:opt, :recall], [:opt, :method_name]],
      ActionDispatchRoutingRouteSetWithFiltering.instance_method(:generate).parameters,
    )
  end

  test "journey router recognize applies filters and restores request path info" do
    routes = draw_routes do
      filter :recognition_marker
      get 'some', :to => 'some#show'
    end

    request = routes.send(:make_request, Rack::MockRequest.env_for('/marker/some'))
    recognized = []

    routes.router.recognize(request) do |_route, params|
      recognized << params
    end

    assert_equal 'yes', recognized.first[:marker]
    assert_equal '/marker/some', request.path_info
  end
end
