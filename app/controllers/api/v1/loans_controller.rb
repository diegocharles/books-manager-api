
class Api::V1::LoansController < ApplicationController
  def index
    @loans = Loan
    .where(book_id: Book.find_by(external_id: params[:book_id]))
    .where('loaned_at > ?', Date.parse(params[:from_date]).beginning_of_day)
    .where('returned_at < ?', Date.parse(params[:to_date]).end_of_day)

    render json: { amount: @loans.sum(:fee)&.to_f }, status: :ok
  end
end
