json.user do
  json.current_balance @user.amount
  json.loans do
    json.array!(@loans, :id, :user_id, :book_id, :fee, :loaned_at, :returned_at)
  end
end