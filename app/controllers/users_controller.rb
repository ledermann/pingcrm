class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy, :restore]

  def index
    @users = current_user.
             account.
             users.
             search(params[:search]).
             trash_filter(params[:trashed]).
             role_filter(params[:role]).
             order_by_name

    render inertia: 'Users/Index', props: {
      filters: {},
      users: @users.as_json(
        only: [ :id, :email, :owner, :deleted_at ],
        methods: [ :name ]
      )
    }
  end

  def new
    @user = User.new

    render inertia: 'Users/New'
  end

  def edit
    render inertia: 'Users/Edit', props: {
      user: @user.as_json(
        only: [
          :id,
          :first_name,
          :last_name,
          :email,
          :owner,
          :deleted_at
        ]
      ).merge(photo: @user.photo.attached? ? polymorphic_url(@user.photo) : nil)
    }
  end

  def create
    @user = current_user.account.users.new(user_params)

    if @user.save
      redirect_to users_path, notice: 'User created.'
    else
      session[:errors] = @user.errors
      redirect_to new_user_path
    end
  end

  def update
    if @user.update(user_params)
      redirect_to [ :edit, @user ], notice: 'User updated.'
    else
      session[:errors] = @user.errors
      redirect_to edit_user_path(@user)
    end
  end

  def destroy
    @user.soft_delete!
    redirect_to edit_user_path(@user), notice: 'User deleted.'
  end

  def restore
    @user.restore!
    redirect_to edit_user_path(@user), notice: 'User restored.'
  end

  private

  def set_user
    @user = current_user.account.users.find(params[:id])
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
