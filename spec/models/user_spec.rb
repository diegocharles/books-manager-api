# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  amount          :decimal(10, 2)   default(0.0)
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  external_id     :string
#
# Indexes
#
#  index_users_on_external_id  (external_id)
#
require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Validations and associations' do
    it { is_expected.to have_many(:loans) }
    it { is_expected.to validate_numericality_of(:amount) }
    it { is_expected.to validate_presence_of(:password) }
  end
end
