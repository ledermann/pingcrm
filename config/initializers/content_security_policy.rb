# Be sure to restart your server when you modify this file.

# Define an application-wide content security policy.
# See the Securing Rails Applications Guide for more information:
# https://guides.rubyonrails.org/security.html#content-security-policy-header

Rails.application.configure do
  config.content_security_policy do |policy|
    policy.font_src     :self
    policy.img_src(*[   :self, :data].compact)
    policy.object_src   :none
    policy.form_action  :self
    policy.manifest_src :self
    policy.default_src :none

    if Rails.env.development?
      policy.connect_src :self,
                         # Allow @vite/client to hot reload changes
                         "ws://#{ViteRuby.config.host_with_port}"

      policy.script_src :self,
                        # Allow @vite/client to hot reload JavaScript changes
                        "http://#{ViteRuby.config.host_with_port}",
                        # Allow Inertia.js to display error modal
                        :unsafe_inline

      policy.style_src :self,
                       # Allow @vite/client to hot reload CSS changes
                       :unsafe_inline
    else
      policy.connect_src(*[:self, ENV.fetch('PLAUSIBLE_URL', nil)].compact)
      policy.script_src(*[:self].compact)
      policy.style_src :self,
                       # Allow @inertiajs/progress to display progress bar
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
