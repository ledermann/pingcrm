class ApplicationController < ActionController::Base
  include DeviseSetup

  include Pagy::Backend

  include InertiaCsrf
  include InertiaErrors
  include InertiaFlash
  include InertiaJson

  inertia_share auth: -> {
    {
      user: current_user.as_json(
        only: [ :id, :first_name, :last_name, :role ],
        include: {
          account: {
            only: [ :id, :name ]
          }
        }
      )
    }
  }
end
