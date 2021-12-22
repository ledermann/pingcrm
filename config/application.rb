require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
# require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
# require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Pingcrm
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.active_storage.variant_processor = :vips

    # To allow Inertia.js handle backend exceptions, we need to register an
    # exceptions_app to show the exceptions via the `Error` Vue component.
    # This app needs to be a middleware. To keep things simple we define an
    # anonymous controller with a `show` method. This allows us to use
    # `render inertia: ...`
    #
    # The exception app will be used if `consider_all_requests_local` is set to false,
    # which is by default in production only
    #
    # More details about exceptions_app:
    # https://guides.rubyonrails.org/configuring.html#rails-general-configuration
    # https://github.com/rails/rails/blob/6-0-stable/actionpack/lib/action_dispatch/middleware/public_exceptions.rb
    #
    config.exceptions_app = ->(env) do
      Class.new(ActionController::Base) do # rubocop:disable Rails/ApplicationController
        def show
          # Get the status code from the path, which is /500 or /404 etc.
          status = request.path_info.delete_prefix('/').to_i

          render inertia: 'Error',
                 props: { status: status }, # Make the status code available to the Vue component
                 status: status             # Return the same status code in the request header
        end
      end.action(:show).call(env)
    end
  end
end
