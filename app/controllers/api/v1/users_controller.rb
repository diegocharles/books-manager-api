class Api::V1::UsersController < ApplicationController
  skip_before_action :authorize_request

  def create
    @user = User.new(user_params)

    if @user.save
      render json: { external_id: @user.external_id }, status: :created
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find_by(external_id: params[:id])
    @loans = @user.loans
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
