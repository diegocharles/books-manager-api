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
class User < ApplicationRecord
  include Externable
  has_secure_password

  has_many :loans

  validates :password, presence: true
  validates :amount, numericality: { greater_than: 0 }
end
