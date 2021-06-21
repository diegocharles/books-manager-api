require 'rails_helper'

RSpec.describe "Api::V1::Books", type: :request do
  let(:book) { FactoryBot.create(:book) }
  let(:user) { FactoryBot.create(:user) }
  let(:headers) do
    {
      'Authorization': JsonWebTokenHelper.encode(user_id: user.id)
    }
  end

  describe "POST /api/v1/books/:book_id/borrow" do
    it "works" do
      params = {
        user_id: user.external_id
      }
      post api_v1_book_borrow_url(book.external_id), headers: headers, params: params
      expect(response).to have_http_status(201)
    end

    it "fails when user has no balance" do
      user.update_attribute(:amount, 0)
      params = {
        user_id: user.external_id
      }
      post api_v1_book_borrow_url(book.external_id), headers: headers, params: params
      expect(response).to have_http_status(422)
      expect(response.body).to include('User has no balance')
    end

    it "fails when some exception is raised" do
      allow(BorrowService).to receive(:loan!).and_raise(StandardError)
      params = {
        user_id: user.external_id
      }
      post api_v1_book_borrow_url(book.external_id), headers: headers, params: params
      expect(response).to have_http_status(422)
      expect(response.body).to include('StandardError')
    end
  end

  describe "PATCH /api/v1/books/:book_id/returnal" do
    it "works" do
      params = {
        user_id: user.external_id
      }
      patch api_v1_book_returnal_url(book.external_id), headers: headers, params: params
      expect(response).to have_http_status(200)
    end
  end
end
