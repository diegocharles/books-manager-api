# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
  password: 'Simple!123',
  password_confirmation: 'Simple!123',
  amount: 1000
)

Book.create!(
  title: 'The ultimate code guide',
  loan_fee: 4.99,
  active_loans: 1,
  units: 100
)