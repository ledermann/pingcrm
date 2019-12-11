class ApplicationController < ActionController::Base
  include DeviseSetup

  include Pagy::Backend

  include InertiaCsrf
  include InertiaErrors
  include InertiaFlash
  include InertiaJson

  inertia_share auth: -> {
    return unless current_user

    jbuilder do |json|
      json.user do
        json.(current_user, :id, :first_name, :last_name)
        json.account(current_user.account, :id, :name)
      end
    end
  }
end
