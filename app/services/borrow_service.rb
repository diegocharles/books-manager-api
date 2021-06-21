class BorrowService
  attr_reader :book, :user, :user_id, :book_id

  def self.loan!(book_id:, user_id:)
    instance = new(book_id, user_id)
    instance.process!
  end

  def initialize(book_id, user_id)
    @book_id = book_id
    @user_id = user_id
  end

  def process!
    Book.transaction do
      Rails.logger.info("[BorrowService] #{__method__} user_id: #{user_id} book_id: #{book_id}")
      find_objects!

      raise NoBalanceError.new(user_id: user_id) if user.amount.zero?

      create_loan!
      deduct_from_units!
    end
  end

  private

  def find_objects!
    @book = Book.find_by!(external_id: book_id)
    @user = User.find_by!(external_id: user_id)
  end

  def create_loan!
    loan = Loan.create!(
      book: book,
      user: user,
      fee: book.loan_fee,
      loaned_at: Time.now
    )
    Rails.logger.info("[BorrowService] #{__method__} Created Loan: #{loan.id} user_id: #{user_id} book_id: #{book_id}")
  end

  def deduct_from_units!
    book.update!(units: book.units - 1)
  end
end