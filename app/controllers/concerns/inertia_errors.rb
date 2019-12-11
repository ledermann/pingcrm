require 'active_support/concern'

# Make errors from session (if there are any) available as shared data
# and override `redirect_to` to move errors into session.
#
# Usage example:
#
#    def create
#      contact = Contact.new(contact_params)
#
#      if contact.save
#        redirect_to contacts_path, notice: 'Contact created.'
#      else
#        redirect_to new_contact_path, errors: contact.errors
#      end
#    end
#
module InertiaErrors
  extend ActiveSupport::Concern

  included do
    inertia_share errors: -> {
      session.delete(:errors) || []
    }
  end

  def redirect_to(options = {}, response_options = {})
    if (errors = response_options.delete(:errors))
      session[:errors] = errors
    end

    super(options, response_options)
  end
end
