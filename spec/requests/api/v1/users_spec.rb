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

  describe "GET /api/v1/users/:id" do
    let(:user) { FactoryBot.create(:user) }
    let(:book) { FactoryBot.create(:book) }
    let(:headers) do
      {
        'Authorization': JsonWebTokenHelper.encode(user_id: user.id)
      }
    end

    before do
      FactoryBot.create(:loan, user: user, book: book)
    end

    it "successfully shows the user details" do
      get api_v1_user_path(user.external_id)

      expected_user_keys = %w(current_balance loans).sort
      expected_loan_keys = %w(id user_id book_id fee loaned_at returned_at).sort
      json = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(json['user'].keys.sort).to eq(expected_user_keys)
      expect(json.dig('user', 'loans').first.keys.sort).to eq(expected_loan_keys)
    end
  end
end
