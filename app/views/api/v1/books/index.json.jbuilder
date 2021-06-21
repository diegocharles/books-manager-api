json.books do
  json.array!(@books, :external_id, :loan_fee, :title, :units)
end