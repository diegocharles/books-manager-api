# == Schema Information
#
# Table name: books
#
#  id           :bigint           not null, primary key
#  active_loans :integer          default(0)
#  loan_fee     :integer
#  title        :string
#  units        :integer          default(0)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  external_id  :string
#
require 'rails_helper'

RSpec.describe Book, type: :model do
  context 'Validations and Associations' do
    it { is_expected.to have_many(:loans) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_numericality_of(:active_loans) }
    it { is_expected.to validate_numericality_of(:loan_fee) }
    it { is_expected.to validate_numericality_of(:units) }
  end
end
