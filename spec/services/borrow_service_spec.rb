require 'rails_helper'

RSpec.describe BorrowService, type: :service do
  let(:user) { FactoryBot.create(:user) }
  let(:book) { FactoryBot.create(:book) }

  context '#loan!' do
    it 'raises NoBalanceError when user.amount is zero' do
      user.update_attribute(:amount, 0)

      expect {
        described_class.loan!(book_id: book.external_id, user_id: user.external_id)
      }.to raise_error(NoBalanceError)
    end

    it 'creates the Loan' do
      expect {
        described_class.loan!(book_id: book.external_id, user_id: user.external_id)
      }.to change {
        Loan.count
      }.by(1)
    end
  end
end
