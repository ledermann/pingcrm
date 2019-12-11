class ContactsController < ApplicationController
  def index
    pagy, paged_contacts = pagy(contacts)

    render inertia: 'Contacts/Index', props: {
      contacts: -> {
        jbuilder do |json|
          json.data(paged_contacts) do |contact|
            json.(contact, :id, :name, :phone, :city, :deleted_at)
            json.organization(contact.organization, :name)
          end
          json.meta pagy_metadata(pagy)
        end
      },
      filters: {}
    }
  end

  def new
    render inertia: 'Contacts/New', props: {
      organizations: -> {
        jbuilder do |json|
          json.array! current_user.account.organizations.order(:name), :id, :name
        end
      }
    }
  end

  def edit
    render inertia: 'Contacts/Edit', props: {
      contact: -> {
        jbuilder do |json|
          json.(contact, :id, :first_name, :last_name, :organization_id, :email, :phone, :address, :city, :region, :country, :postal_code, :deleted_at)
        end
      },
      organizations: -> {
        jbuilder do |json|
          json.array! current_user.account.organizations.order(:name), :id, :name
        end
      }
    }
  end

  def create
    if new_contact.update(contact_params)
      redirect_to contacts_path, notice: 'Contact created.'
    else
      redirect_to new_contact_path, errors: new_contact.errors
    end
  end

  def update
    if contact.update(contact_params)
      redirect_to edit_contact_path(contact), notice: 'Contact updated.'
    else
      redirect_to edit_contact_path(contact), errors: contact.errors
    end
  end

  def destroy
    if contact.soft_delete
      redirect_to edit_contact_path(contact), notice: 'Contact deleted.'
    else
      redirect_to edit_contact_path(contact), alert: 'Contact be deleted!'
    end
  end

  def restore
    if contact.restore
      redirect_to edit_contact_path(contact), notice: 'Contact restored.'
    else
      redirect_to edit_contact_path(contact), alert: 'Contact be restored!'
    end
  end

  private

  def contact
    @contact ||= current_user.account.contacts.find(params[:id])
  end

  def contacts
    @contacts ||= current_user.
                  contacts.
                  includes(:organization).
                  search(params[:search]).
                  trash_filter(params[:trashed]).
                  order_by_name
  end

  def new_contact
    @new_contact ||= current_user.account.contacts.new
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def contact_params
    params.require(:contact).permit(
      :organization_id,
      :first_name,
      :last_name,
      :email,
      :phone,
      :address,
      :city,
      :region,
      :country,
      :postal_code
    )
  end
end
