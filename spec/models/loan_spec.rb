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
