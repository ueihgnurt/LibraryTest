# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :find_book, except: %i[new index create]

  def new
    @book = Book.new
    @book.bookcategories.build
  end

  def index
    @search = Book.search_name(params[:keyword]).sort_created_at
    @sort = ['Default', 'Name of book', 'Name of author']
    @pagy, @books = pagy(@search, items: 9)
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

  def edit; end

  def update
    return redirect_to book_path if @book.update(book_params)

    redirect_to edit_book_path
  end

  def destroy
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:name, :quantity, :publisher,
                                 :page, :author_id, :book_img,
                                 bookcategories_attributes: %i[book_id category_id _destroy])
  end

  def find_book
    @book = Book.find_by(id: params[:id])
    return if @book

    flash[:danger] = 'this book is not existed'
    render :index
  end
end
