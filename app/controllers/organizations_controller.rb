class OrganizationsController < ApplicationController
  def index
    pagy, paged_organizations = pagy(organizations)

    render inertia: 'Organizations/Index', props: {
      organizations: jbuilder do |json|
        json.data(paged_organizations, :id, :name, :phone, :city, :deleted_at)
        json.meta pagy_metadata(pagy)
      end,
      filters: params.slice(:search, :trashed)
    }
  end

  def new
    render inertia: 'Organizations/New'
  end

  def edit
    render inertia: 'Organizations/Edit', props: {
      organization: jbuilder do |json|
        json.(organization, :id, :name, :email, :phone, :address, :city, :region, :country, :postal_code, :deleted_at)
      end,
      contacts: -> {
        jbuilder do |json|
          json.array! organization.contacts.order_by_name, :id, :name, :phone, :city, :deleted_at
        end
      }
    }
  end

  def create
    if new_organization.update(organization_params)
      redirect_to organizations_path, notice: 'Organization created.'
    else
      redirect_to new_organization_path, errors: new_organization.errors
    end
  end

  def update
    if organization.update(organization_params)
      redirect_to edit_organization_path(organization), notice: 'Organization updated.'
    else
      redirect_to edit_organization_path(organization), errors: organization.errors
    end
  end

  def destroy
    if organization.soft_delete
      redirect_to edit_organization_path(organization), notice: 'Organization deleted.'
    else
      redirect_to edit_organization_path(organization), alert: 'Organization cannot be deleted!'
    end
  end

  def restore
    if organization.restore
      redirect_to edit_organization_path(organization), notice: 'Organization restored.'
    else
      redirect_to edit_organization_path(organization), alert: 'Organization cannot be restored!'
    end
  end

  private

  def organization
    @organization ||= current_user.organizations.find(params[:id])
  end

  def organizations
    @organizations ||= current_user.
                       organizations.
                       search(params[:search]).
                       trash_filter(params[:trashed]).
                       order(:name)
  end

  def new_organization
    @new_organization ||= current_user.account.organizations.new
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def organization_params
    params.require(:organization).permit(
      :name, :email, :phone, :address, :city, :region, :country, :postal_code
    )
  end
end
