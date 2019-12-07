class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:edit, :update, :destroy, :restore]

  def index
    @organizations = current_user.
                     organizations.
                     search(params[:search]).
                     trash_filter(params[:trashed]).
                     order(:name)

    pagy, records = pagy(@organizations)

    render inertia: 'Organizations/Index', props: {
      filters: {},
      organizations: {
        data: records.as_json(
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
    @organization = Organization.new

    render inertia: 'Organizations/New'
  end

  def edit
    render inertia: 'Organizations/Edit', props: {
      organization: @organization.as_json(
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
      ).merge(
        contacts: @organization.contacts.order_by_name.as_json(
          only: [:id, :city, :phone],
          methods: [ :name ]
        )
      )
    }
  end

  def create
    @organization = current_user.account.organizations.new(organization_params)

    if @organization.save
      redirect_to organizations_path, notice: 'Organization created.'
    else
      session[:errors] = @organization.errors
      redirect_to new_organization_path
    end
  end

  def update
    if @organization.update(organization_params)
      redirect_to [ :edit, @organization ], notice: 'Organization updated.'
    else
      session[:errors] = @organization.errors
      redirect_to edit_organization_path(@organization)
    end
  end

  def destroy
    @organization.soft_delete!
    redirect_to edit_organization_path(@organization), notice: 'Organization deleted.'
  end

  def restore
    @organization.restore!
    redirect_to edit_organization_path(@organization), notice: 'Organization restored.'
  end

  private

  def set_organization
    @organization = current_user.account.organizations.find(params[:id])
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
