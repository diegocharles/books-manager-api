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
  has_secure_password

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true
end
