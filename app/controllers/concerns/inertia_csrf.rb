require 'active_support/concern'

# Store the CSRF token in a non-session cookie so Axios can access it
# Name it as XSRF-TOKEN, because this is the Axios default
#
# Important: Axios needs to be told the name of the header to set:
#   axios.defaults.xsrfHeaderName = 'X-CSRF-Token'
#
# More info: https://pragmaticstudio.com/tutorials/rails-session-cookies-for-api-authentication
#
module InertiaCsrf
  extend ActiveSupport::Concern

  included do
    before_action :set_csrf_cookie
  end

  private

  def set_csrf_cookie
    cookies['XSRF-TOKEN'] = form_authenticity_token
  end
end
