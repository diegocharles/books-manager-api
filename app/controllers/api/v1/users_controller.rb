class Api::V1::UsersController < ApplicationController
  skip_before_action :authorize_request

  def create
    @user = User.new(user_params)

    if @user.save
      render status: :created
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :amount,
      :password,
      :password_confirmation
    )
  end
end
