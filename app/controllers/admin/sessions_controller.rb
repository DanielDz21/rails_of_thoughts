class Admin::SessionsController < ApplicationController
  def new; end

  def create
    if user = User.authenticate_by(email: params[:email], password: params[:password], admin: true)
      login user

      redirect_to root_path
    else
      render :new, status: :unauthorized
    end
  end

  def destroy
    logout current_user

    redirect_to root_path
  end
end
