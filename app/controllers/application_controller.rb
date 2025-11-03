class ApplicationController < ActionController::Base
  include Auth

  include Pagy::Method

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

  private

  def pagy_metadata(pagy)
    pagy.data_hash
  end
end
