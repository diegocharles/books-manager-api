require 'rails_helper'

RSpec.describe "Api::V1::Sessions", type: :request do
  let(:user) do
    FactoryBot.create(:user,
      external_id: '1234',
      password: 'foobar',
      password_confirmation: 'foobar'
    )
  end

  describe "GET /api/v1/sessions" do
    it "successfully creates a new session" do
      params = {
        user: {
          external_id: user.external_id,
          password: user.password
        }
      }

      post api_v1_session_url(params)
      expect(response).to have_http_status(201)
      json = JSON.parse(response.body)
      expect(json['token']).to_not be_nil
    end

    it "fails when the given credentials are bad" do
      params = {
        user: {
          external_id: user.external_id,
          password: 'banana'
        }
      }

      post api_v1_session_url(params)
      expect(response).to have_http_status(401)
    end
  end
end
