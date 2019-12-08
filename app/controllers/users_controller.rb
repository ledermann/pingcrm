class UsersController < ApplicationController
  def index
    render inertia: 'Users/Index', props: {
      filters: {},
      can: {
        create_user: current_user.owner?
      },
      users: users.map do |user|
        {
          id:         user.id,
          email:      user.email,
          owner:      user.owner,
          deleted_at: user.deleted_at,
          name:       user.name,
          can: {
            edit_user: current_user.owner?
          }
        }
      end
    }
  end

  def new
    unless current_user.owner?
      redirect_to users_path, alert: 'You are not allowed to do this!'
      return
    end

    render inertia: 'Users/New'
  end

  def edit
    render inertia: 'Users/Edit', props: {
      can: {
        edit_user: current_user.owner?
      },
      user: {
        id:         user.id,
        email:      user.email,
        owner:      user.owner,
        deleted_at: user.deleted_at,
        first_name: user.first_name,
        last_name:  user.last_name,
        photo: user.photo.attached? ? polymorphic_url(user.photo.variant(resize_to_fill: [64, 64])) : nil
      }
    }
  end

  def create
    unless current_user.owner?
      redirect_to users_path, alert: 'You are not allowed to do this!'
      return
    end

    new_user = current_user.account.users.new(user_params)

    if new_user.save
      redirect_to users_path, notice: 'User created.'
    else
      session[:errors] = new_user.errors
      redirect_to new_user_path
    end
  end

  def update
    unless current_user.owner?
      redirect_to edit_user_path(user), alert: 'You are not allowed to do this!'
      return
    end

    if user.update(user_params)
      redirect_to [ :edit, user ], notice: 'User updated.'
    else
      session[:errors] = user.errors
      redirect_to edit_user_path(user)
    end
  end

  def destroy
    unless current_user.owner?
      redirect_to edit_user_path(user), alert: 'You are not allowed to do this!'
      return
    end

    user.soft_delete!
    redirect_to edit_user_path(user), notice: 'User deleted.'
  end

  def restore
    user.restore!
    redirect_to edit_user_path(user), notice: 'User restored.'
  end

  private

  def user
    @user ||= current_user.account.users.find(params[:id])
  end

  def users
    @users ||= current_user.
               users.
               search(params[:search]).
               trash_filter(params[:trashed]).
               role_filter(params[:role]).
               order_by_name
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :owner,
      :password,
      :photo
    ).tap do |p|
      p.delete(:photo) if p[:photo].blank?
    end
  end
end
