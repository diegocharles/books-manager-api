# frozen_string_literal: true
require 'rails_helper'

module Api::V1
  class SessionsController < ApplicationController
    skip_before_action :authorize_request, only: :create

    def create
      @user = User.find_by(external_id: user_params[:external_id])

      if @user&.authenticate(user_params[:password])
        JsonWebTokenHelper.encode(user_id: @user.id)
        render status: :created
      else
        render json: { error: 'Bad Credentials' }, status: :unauthorized
      end
    end

    private

    def user_params
      params.require(:user).permit(
        :external_id,
        :password
      )
    end
  end
end
