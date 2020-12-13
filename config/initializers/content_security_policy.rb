# Be sure to restart your server when you modify this file.

# Define an application-wide content security policy
# For further information see the following documentation
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy

Rails.application.config.content_security_policy do |policy|
  policy.default_src :none
  policy.font_src     :self
  policy.img_src(*[   :self, :data, ENV['MATOMO_HOST']].compact)
  policy.object_src   :none
  policy.form_action  :self
  policy.manifest_src :self

  if Rails.env.development?
    # If you are using webpack-dev-server then specify webpack-dev-server host
    policy.connect_src :self, 'http://localhost:3035', 'ws://localhost:3035'

    # Inertia.js uses inline scripts to display error modal in development
    policy.script_src :self, :unsafe_inline, 'https://polyfill.io'
  else
    policy.connect_src(*[:self, ENV['MATOMO_HOST']].compact)
    policy.script_src(*[:self, 'https://polyfill.io', ENV['MATOMO_HOST']].compact)
  end

  # @inertiajs/progress uses inline styles
  policy.style_src :self, :unsafe_inline

  policy.base_uri :self

  # Specify URI for violation reports
  # policy.report_uri "/csp-violation-report-endpoint"
end

# If you are using UJS then enable automatic nonce generation
# Rails.application.config.content_security_policy_nonce_generator = -> request { SecureRandom.base64(16) }

# Set the nonce only to specific directives
# Rails.application.config.content_security_policy_nonce_directives = %w(script-src)

# Report CSP violations to a specified URI
# For further information see the following documentation:
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy-Report-Only
# Rails.application.config.content_security_policy_report_only = true
