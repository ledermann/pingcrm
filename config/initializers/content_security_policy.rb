# Be sure to restart your server when you modify this file.

# Define an application-wide content security policy.
# See the Securing Rails Applications Guide for more information:
# https://guides.rubyonrails.org/security.html#content-security-policy-header

Rails.application.configure do
  config.content_security_policy do |policy|
    policy.font_src     :self
    policy.img_src(*[   :self, :data, ENV.fetch('MATOMO_HOST', nil)].compact)
    policy.object_src   :none
    policy.form_action  :self
    policy.manifest_src :self

    if Rails.env.development?
      policy.connect_src :self, "http://#{ViteRuby.config.host_with_port}", "ws://#{ViteRuby.config.host_with_port}"

      # Inertia.js uses inline scripts to display error modal in development
      policy.script_src :self, :unsafe_inline, :unsafe_eval, "http://#{ViteRuby.config.host_with_port}"
    else
      policy.default_src :none
      policy.connect_src(*[:self, ENV.fetch('MATOMO_HOST', nil)].compact)
      policy.script_src(*[:self, ENV.fetch('MATOMO_HOST', nil)].compact)
      policy.style_src :self,
                       # @inertiajs/progress uses inline styles to display progress bar
                       "'sha256-kCeyw5rRT2DINADvWYmAhXLhQs4dKZrnn2sofIDmprs='"
    end

    policy.base_uri :self

    # Specify URI for violation reports
    # policy.report_uri "/csp-violation-report-endpoint"
  end

  # Generate session nonces for permitted importmap and inline scripts
  #   config.content_security_policy_nonce_generator = ->(request) { request.session.id.to_s }
  #   config.content_security_policy_nonce_directives = %w(script-src)
  #
  #   # Report violations without enforcing the policy.
  #   # config.content_security_policy_report_only = true
end
