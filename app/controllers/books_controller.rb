class BooksController < ApplicationController
  before_action :find_book, only: [:show]
  before_action :find_user, only: [:show]

  def new
    @book = Book.new
    @book.bookcategories.build
  end

  def index
    @categories = Category.all
    @authors = Author.all
    @q = Book.search(params[:q])
    @search = @q.result(distinct: true)

    @pagy, @books = pagy(@search.order('created_at DESC'), items: 9)
    @sort = ['Default', 'Name of book', 'Name of author']
    respond_to do |format|
      format.html
      format.js
      format.json { render json: @books }
    end
    # byebug
  end

  def show
    @q = Book.search(params[:q])
    @search = @q.result(distinct: true)
    @categories = Category.all
    @authors = Author.all
    # byebug
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    # byebug
    @book = Book.new(book_params)
    if @book.save
      flash[:success] = 'Creating book success'
      redirect_to @book
    else
      flash[:danger] = 'Creating book failed'
      render 'new'
    end
  end

  private

  def book_params
    params.require(:book).permit(:name, :quantity, :publisher,
                                 :page, :author_id, :book_img,
                                 bookcategories_attributes: %i[book_id category_id _destroy])
  end

  def find_book
    @book = Book.find(params[:id])
  end

  def find_user
    @user = current_user
  end
end
