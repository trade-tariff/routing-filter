# frozen_string_literal: true

# Prepend the method lookup to intercept route recognition in rails.
#
# This enables us to intercept the incoming route paths before they are
# recognized by the rails router and transformed to a route set and dispatched
# to a controller.
module ActionDispatchJourneyRouterWithFiltering
  def recognize(req, &block)
    path = req.path_info.dup
    original_path = path.dup
    filter_parameters = {}

    # Apply the custom user around_recognize filter callbacks
    @routes.filters.run(:around_recognize, path, req) do
      # Yield the filter parameters for adjustment by the user
      filter_parameters
    end

    # Filters mutate path in-place; set it back before super reads req.path_info
    req.path_info = path

    # Recognize the routes
    super(req) do |route, parameters|
      # Merge in custom parameters that will be visible to the controller
      params = parameters.merge(filter_parameters)

      # Reset the path before yielding to the controller (prevents breakages in CSRF validation).
      # Only do this for anchored routes. For a mounted app (an unanchored route) Rails has
      # already moved the mount path into SCRIPT_NAME and set PATH_INFO to the remainder,
      # and it restores both itself after the app returns.
      req.path_info = original_path if route.path.anchored
      block.call(route, params)
    end
  end
end

ActionDispatch::Journey::Router.prepend(ActionDispatchJourneyRouterWithFiltering)
