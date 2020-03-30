# Devise: Redirect user to login page on auth failure
#
class AuthFailure < Devise::FailureApp
  def http_auth?
    if request.inertia?
      # Explicitly disable HTTP authentication on Inertia
      # requests and force a redirect on failure
      false
    else
      super
    end
  end
end
