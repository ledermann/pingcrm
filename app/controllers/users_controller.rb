class UsersController < ApplicationController
  # Let CanCanCan load and authorize the instance variables
  load_and_authorize_resource

  def index
    @users = @users.
             search(params[:search]).
             trash_filter(params[:trashed]).
             role_filter(params[:role]).
             order_by_name

    render inertia: 'Users/Index', props: {
      users: jbuilder do |json|
        json.array! @users do |user|
          json.(user, :id, :email, :name, :owner, :deleted_at)
          json.photo user.photo.attached? ? polymorphic_url(user.photo.variant(resize_to_fill: [64, 64])) : nil
          json.can do
            json.edit_user can?(:edit, user)
          end
        end
      end,
      can: {
        create_user: can?(:create, User)
      },
      filters: params.slice(:search, :trashed, :role)
    }
  end

  def new
    render inertia: 'Users/New', props: {
      user: jbuilder do |json|
        json.(@user, :email, :first_name, :last_name, :owner)
      end
    }
  end

  def edit
    render inertia: 'Users/Edit', props: {
      user: jbuilder do |json|
        json.(@user, :id, :email, :first_name, :last_name, :owner, :deleted_at)
        json.photo @user.photo.attached? ? polymorphic_url(@user.photo.variant(resize_to_fill: [64, 64])) : nil
      end,
      can: {
        edit_user: can?(:update, @user)
      }
    }
  end

  def create
    if @user.update(user_params)
      redirect_to users_path, notice: 'User created.'
    else
      redirect_to new_user_path, inertia: { errors: @user.errors }
    end
  end

  def update
    if @user.demo?
      redirect_to edit_user_path(@user), alert: 'Updating the demo user is not allowed.'
      return
    end

    if @user.update(user_params)
      redirect_to edit_user_path(@user), notice: 'User updated.'
    else
      redirect_to edit_user_path(@user), inertia: { errors: @user.errors }
    end
  end

  def destroy
    if @user.demo?
      redirect_to edit_user_path(@user), alert: 'Deleting the demo user is not allowed.'
      return
    end

    if @user.soft_delete
      redirect_to edit_user_path(@user), notice: 'User deleted.'
    else
      redirect_to edit_user_path(@user), alert: 'User cannot be deleted!'
    end
  end

  def restore
    if @user.restore
      redirect_to edit_user_path(@user), notice: 'User restored.'
    else
      redirect_to edit_user_path(@user), alert: 'User cannot be restored!'
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def user_params
    params.fetch(:user, {}).permit(
      :first_name, :last_name, :email, :owner, :password, :photo
    ).tap do |p|
      p.delete(:photo) if p[:photo].blank?
    end
  end
end
