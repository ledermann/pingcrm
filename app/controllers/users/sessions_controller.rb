class Users::SessionsController < Devise::SessionsController
  # GET /login
  def new
    render inertia: 'Auth/Login', props: {}
  end

  # POST /login
  def create
    super
  end

  # DELETE /logout
  def destroy
    super
  end
end
