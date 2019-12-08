class OrganizationsController < ApplicationController
  def index
    pagy, paged_organizations = pagy(organizations)

    render inertia: 'Organizations/Index', props: {
      filters: {},
      organizations: {
        data: paged_organizations.as_json(
          only: [
            :id,
            :name,
            :phone,
            :city,
            :deleted_at
          ]
        ),
        meta: pagy_metadata(pagy)
      }
    }
  end

  def new
    render inertia: 'Organizations/New'
  end

  def edit
    render inertia: 'Organizations/Edit', props: {
      organization: organization.as_json(
        only: [
          :id,
          :name,
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
      contacts: organization.contacts.order_by_name.as_json(
        only: [:id, :city, :phone],
        methods: [ :name ]
      )
    }
  end

  def create
    new_organization = current_user.account.organizations.new(organization_params)

    if new_organization.save
      redirect_to organizations_path, notice: 'Organization created.'
    else
      session[:errors] = new_organization.errors
      redirect_to new_organization_path
    end
  end

  def update
    if organization.update(organization_params)
      redirect_to [ :edit, organization ], notice: 'Organization updated.'
    else
      session[:errors] = organization.errors
      redirect_to edit_organization_path(organization)
    end
  end

  def destroy
    organization.soft_delete!
    redirect_to edit_organization_path(organization), notice: 'Organization deleted.'
  end

  def restore
    organization.restore!
    redirect_to edit_organization_path(organization), notice: 'Organization restored.'
  end

  private

  def organization
    @organization ||= current_user.account.organizations.find(params[:id])
  end

  def organizations
    @organizations ||= current_user.
                       organizations.
                       search(params[:search]).
                       trash_filter(params[:trashed]).
                       order(:name)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def organization_params
    params.require(:organization).permit(
      :name,
      :email,
      :phone,
      :address,
      :city,
      :region,
      :country,
      :portal_code
    )
  end
end
