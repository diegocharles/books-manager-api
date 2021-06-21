class Api::V1::BooksController < ApplicationController
  before_action :find_book, except: :index

  def index
    @books = Book.all
  end

  def borrow
    BorrowService.loan!(book_id: params[:book_id], user_id: params[:user_id])
    head :created

  rescue NoBalanceError
    render json: { errors: 'User has no balance' }, status: :unprocessable_entity
  rescue StandardError => e
    render json: { errors: e.message }, status: :unprocessable_entity
  end

  def returnal
    ReturnalService.process!(user_id: params[:user_id], book_id: params[:book_id])
    head :ok
  end

  private

  def find_book
    Book.find_by(external_id: params[:book_id])
  end
end
