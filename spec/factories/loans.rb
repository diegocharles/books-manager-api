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
FactoryBot.define do
  factory :loan do
    fee         { 4.99 }
    loaned_at   { 10.days.ago }
    returned_at { 7.days.ago }
    book        { FactoryBot.create(:book) }
    user        { FactoryBot.create(:user) }
  end
end
