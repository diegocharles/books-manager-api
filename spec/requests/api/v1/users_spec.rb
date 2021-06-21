require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  describe "POST /api/v1/users" do
    it "successfully creates an User" do
      params = {
        user: {
          amount: 500,
          password: 'foobar',
          password_confirmation: 'foobar'
        }
      }

      post api_v1_users_path(params)
      expect(response).to have_http_status(201)
    end

    it "returns the error when it fails" do
      params = {
        user: {
          amount: 500,
        }
      }

      post api_v1_users_path(params)
      expect(response).to have_http_status(422)
      json = JSON.parse(response.body)
      expect(json['errors'].keys).to include('password')
    end
  end
end
