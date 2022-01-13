require 'active_support/concern'

# Helper method to build a complex Hash with Jbuilder
#
# Usage example:
#
#   class ContactsController < ApplicationController
#     def index
#       render inertia: 'Contacts/Index', props: {
#         contacts: {
#           jbuilder do |json|
#             json.data(contacts) do |contact|
#               json.(contact, :id, :name)
#               json.organization(contact.organization, :name)
#             end
#           end
#         }
#       }
#     end
#   end
#
module InertiaJson
  extend ActiveSupport::Concern

  def jbuilder(&)
    JbuilderTemplate.new(view_context, &).attributes!
  end
end
