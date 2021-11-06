# Use it with: "rails generate routes"
#
require 'js-routes'

JsRoutes.setup do |config|
  config.exclude = [
    /rails_/
  ]
  config.compact = true
end

class RoutesGenerator < Rails::Generators::Base
  desc 'This generator creates named routes for the client side'

  def create_initializer_file
    create_file "app/javascript/utils/routes.js", JsRoutes.generate
  end
end
