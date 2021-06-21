require 'rails_helper'

RSpec.describe ReturnalService, type: :service do
  let(:user) { FactoryBot.create(:user) }
  let(:book) { FactoryBot.create(:book, units: 39) }
  before do
    FactoryBot.create(:loan, user: user, book: book, returned_at: nil)
  end

  context '#run!' do
    it 'sets the returnal date' do
      described_class.process!(book_id: book.external_id, user_id: user.external_id)
      expect(Loan.last.returned_at.to_date).to eql(Date.today)
    end

    it 'sets the returnal date' do
      expect {
        described_class.process!(book_id: book.external_id, user_id: user.external_id)
      }.to change {
        book.reload.units
      }.from(39).to(40)
    end
  end
end
