class ApplicationController < ActionController::Base
  before_action :set_csrf_cookie
  before_action :authenticate_user!

  include Pagy::Backend

  inertia_share do
    {
      errors: session.delete(:errors) || [],
      flash: {
        success: flash.notice,
        alert: flash.alert
      },
      auth: {
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

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || root_path
  end

  def after_sign_out_path_for(_resource_or_scope)
    new_user_session_path
  end

  private

  def set_csrf_cookie
    cookies["CSRF-TOKEN"] = form_authenticity_token
  end
end
