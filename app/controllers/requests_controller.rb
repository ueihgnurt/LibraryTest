class RequestsController < ApplicationController
  before_action :find_user, only: %i[new create destroy]
  before_action :find_book, only: %i[new create]
  before_action :find_request, only: [:destroy]
  def new
    @request = Request.new
  end

  def create
    return if @user.nil?

    @request = Request.new

    if @user.carts.last && @user.carts.last.verify == 3
      book_ids = book_ids @user.carts.last.requests
      check = book_ids.include? @book.id
      @request.cart_id = @user.carts.last.id
      @request.book_id = @book.id if @book.quantity > 0 && check == false
    else
      @request.cart_id = @user.carts.create.id
      @request.book_id = @book.id if @book.quantity > 0
    end
    if @request.save
      respond_to do |format|
        format.html
        format.js
        # format json {render: @request.id}
      end
    end
  end

  def book_ids(requests)
    arr = []
    requests.each do |r|
      arr << r.book_id
    end
    arr
  end

  def destroy
    if @request.destroy
      redirect_to cart_path(@user.carts.last.id)
    else
      redirect_to books_url
    end
  end

  private

  def find_book
    @book = Book.find(params[:book_id])
  end

  def find_user
    @user = current_user
  end

  def find_request
    @request = Request.find_by(id: params[:id])
  end
end
