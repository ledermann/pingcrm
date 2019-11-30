class ApplicationController < ActionController::Base
  include Pagy::Backend

  def current_user
    @current_user ||= User.first
  end

  inertia_share do
    {
      errors: session.delete(:errors) || [],
      flash: {
        success: flash.notice,
        alert: flash.alert
      },
      auth: {
        user: {
          id: 1,
          name: "john",
          first_name: 'John',
          last_name: 'Doe',
          role: 'Admin',
          account: {
            id: 1,
            name: 'Acme Corporation'
          }
        }
      }
    }
  end

  before_action :set_csrf_cookie

  private

  def set_csrf_cookie
    cookies["CSRF-TOKEN"] = form_authenticity_token
  end
end
