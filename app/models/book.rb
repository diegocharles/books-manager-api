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
class Book < ApplicationRecord
  has_many :loans

  validates :active_loans,  numericality: { greater_than: 0 }
  validates :loan_fee,      numericality: { greater_than: 0.0 }
  validates :title,         presence: true
  validates :units,         numericality: { greater_than: 0 }
end
