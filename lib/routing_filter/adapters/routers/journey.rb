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

    # Apply the custom user around_recognize filter callbacks
    @routes.filters.run(:around_recognize, path, env) do
      # Yield the filter paramters for adjustment by the user
      filter_parameters
    end

    # Recognize the routes
    super(env) do |match, parameters, route|
      # Merge in custom parameters that will be visible to the controller
      params = (parameters || {}).merge(filter_parameters)

      # Reset the path before yielding to the controller (prevents breakages in CSRF validation)
      if env.is_a?(Hash)
        env['PATH_INFO'] = original_path
      else
        env.path_info = original_path
      end

      # Yield results are dispatched to the controller
      yield [match, params, route]
    end
  end
end

ActionDispatch::Journey::Router.prepend(ActionDispatchJourneyRouterWithFiltering)
