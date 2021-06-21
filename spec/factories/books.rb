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
FactoryBot.define do
  factory :book do
    active_loans { 2 }
    loan_fee     { 4.99 }
    title        { "The wise's book" }
    units        { 10 }
  end
end
