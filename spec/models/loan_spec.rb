# == Schema Information
#
# Table name: loans
#
#  id          :bigint           not null, primary key
#  fee         :decimal(10, 2)
#  loaned_at   :datetime
#  returned_at :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  book_id     :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_loans_on_book_id  (book_id)
#  index_loans_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (book_id => books.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Loan, type: :model do
  context 'Validations and Associations' do
    it { is_expected.to belong_to(:book) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to validate_presence_of(:loaned_at) }
    it { is_expected.to validate_presence_of(:returned_at) }
    it { is_expected.to validate_numericality_of(:fee) }
  end
end
