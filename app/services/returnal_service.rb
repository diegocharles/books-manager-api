class ReturnalService
  attr_reader :book, :user, :user_id, :book_id

  def self.process!(book_id:, user_id:)
    instance = new(book_id, user_id)
    instance.run!
  end

  def initialize(book_id, user_id)
    @book_id = book_id
    @user_id = user_id
  end

  def run!
    Book.transaction do
      Rails.logger.info("[ReturnalService] #{__method__} user_id: #{user_id} book_id: #{book_id}")
      find_objects

      find_and_update_loans!
      update_available_units!
    end
  end

  private

  def find_objects
    @book = Book.find_by!(external_id: book_id)
    @user = User.find_by!(external_id: user_id)
  end

  def find_and_update_loans!
    Loan.where(user: user, book: book).each do |loan|
      loan.touch(:returned_at)
      user.update!(amount: user.amount - loan.fee)
      Rails.logger.info("[ReturnalService] #{__method__} user_id: #{user_id} book_id: #{book_id} loan_id: #{loan.id}")
    end
  end

  def update_available_units!
    book.update!(units: book.units + 1)
  end
end