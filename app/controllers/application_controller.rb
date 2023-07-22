class ApplicationController < ActionController::Base
  include Auth

  include Pagy::Backend

  include InertiaCsrf
  include InertiaFlash
  include InertiaJson

  inertia_share auth: -> {
                  {
                    user:
                      current_user.as_json(
                        only: %i[id first_name last_name],
                        include: {
                          account: {
                            only: %i[id name],
                          },
                        },
                      ),
                  }
                }
end
