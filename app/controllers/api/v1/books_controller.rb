class Api::V1::BooksController < ApplicationController
  before_action :find_book

  def borrow

  end

  def returnal

  end

  private

  def find_book
    Book.find_by(external_id: params[:external_id])
  end
end
