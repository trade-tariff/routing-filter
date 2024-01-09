# frozen_string_literal: true

# Prepend the method lookup to intercept find_routes in rails.
#
# This enables us to intercept the incoming route paths before they are
# recognized by the rails router and transformed to a route set and dispatched
# to a controller.
module ActionDispatchJourneyRouterWithFiltering
  def find_routes(env)
    path = if env.is_a?(Hash)
             env['PATH_INFO']
           else
             env.path_info
           end

    filter_parameters = {}
    original_path = path.dup

    @routes.filters.run(:around_recognize, path, env) do
      filter_parameters
    end

    super(env) do |match, parameters, route|
      params = (parameters || {}).merge(filter_parameters)

      if env.is_a?(Hash)
        env['PATH_INFO'] = original_path
      else
        env.path_info = original_path
      end

      yield [match, params, route]
    end
  end
end

ActionDispatch::Journey::Router.prepend(ActionDispatchJourneyRouterWithFiltering)
