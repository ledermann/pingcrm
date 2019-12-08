class ContactsController < ApplicationController
  def index
    pagy, paged_contacts = pagy(contacts)

    render inertia: 'Contacts/Index', props: {
      filters: {},
      contacts: {
        data: paged_contacts.as_json(
          only: [ :id, :phone, :city, :deleted_at ],
          methods: [ :name ],
          include: {
            organization: {
              only: [ :name ]
            }
          }
        ),
        meta: pagy_metadata(pagy)
      }
    }
  end

  def new
    render inertia: 'Contacts/New', props: {
      organizations: current_user.account.organizations.order(:name).as_json(only: [ :id, :name ])
    }
  end

  def edit
    render inertia: 'Contacts/Edit', props: {
      contact: contact.as_json(
        only: [
          :id,
          :first_name,
          :last_name,
          :organization_id,
          :email,
          :phone,
          :address,
          :city,
          :region,
          :country,
          :postal_code,
          :deleted_at
        ]
      ),
      organizations: current_user.account.organizations.order(:name).as_json(
        only: [:id, :name]
      )
    }
  end

  def create
    new_contact = current_user.account.contacts.new(contact_params)

    if new_contact.save
      redirect_to contacts_path, notice: 'Contact created.'
    else
      session[:errors] = new_contact.errors
      redirect_to new_contact_path
    end
  end

  def update
    if contact.update(contact_params)
      redirect_to [ :edit, contact ], notice: 'Contact updated.'
    else
      session[:errors] = contact.errors
      redirect_to edit_contact_path(contact)
    end
  end

  def destroy
    contact.soft_delete!
    redirect_to edit_contact_path(contact), notice: 'Contact deleted.'
  end

  def restore
    contact.restore!
    redirect_to edit_contact_path(contact), notice: 'Contact restored.'
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
