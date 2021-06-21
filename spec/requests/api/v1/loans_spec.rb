require 'rails_helper'

RSpec.describe "Loans", type: :request do
  describe "GET /api/v1/loans" do
    let(:user) { FactoryBot.create(:user) }
    let(:book) { FactoryBot.create(:book) }
    let(:headers) do
      {
        'Authorization': JsonWebTokenHelper.encode(user_id: user.id)
      }
    end

    before do
      FactoryBot.create_list(:loan, 2,
        user: user,
        book: book,
        fee: 5.0,
        loaned_at: 3.days.ago,
        returned_at: Date.today
      )

      FactoryBot.create(:loan,
        user: user,
        book: book,
        fee: 5.0,
        loaned_at: 13.days.ago,
        returned_at: 10.days.ago
      )
    end

    it "successfully shows the user details" do
      params = {
        book_id: book.external_id,
        from_date: 12.days.ago,
        to_date: Date.today
      }

      get api_v1_loans_path, headers: headers, params: params

      expect(response).to have_http_status(200)

      json = JSON.parse(response.body)

      expect(json['amount']).to eq(10.0)
    end
  end
end
