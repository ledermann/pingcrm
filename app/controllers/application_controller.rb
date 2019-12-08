class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_csrf_cookie

  include Pagy::Backend

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

  inertia_share errors: -> {
    session.delete(:errors) || []
  }

  inertia_share flash: -> {
    {
      success: flash.notice,
      alert: flash.alert
    }
  }

  protected

  # Render Hash with Jbuilder
  def jbuilder
    JbuilderTemplate.new(view_context) do |json|
      yield(json)
    end.attributes!
  end

  private

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || root_path
  end

  def after_sign_out_path_for(_resource_or_scope)
    new_user_session_path
  end

  # Store the CSRF token in a non-session cookie so Axios can access it
  # https://pragmaticstudio.com/tutorials/rails-session-cookies-for-api-authentication
  def set_csrf_cookie
    cookies['XSRF-TOKEN'] = form_authenticity_token
  end
end
