# frozen_string_literal: true

class AuthorsController < ApplicationController
  before_action :find_author, only: %i[show destroy]

  def admin
    @search = Author.search_name(params[:keyword])
    if params[:sort].blank?
      @sort = "asc"
    else
      @sort = params[:sort]
    end
    @pagy, @authors = pagy(@search.order(name: @sort.to_sym), items: 9) 
  end 

  def new
    @author = Author.new
  end

  def index
    @search = Author.search_name(params[:keyword])
    @pagy, @authors = pagy(@search, items: 9)
  end

  def show
    @q = Author.search(params[:q])
    @search = @q.result(distinct: true)
    @books = @author.books
    @authors = Author.all
  end

  def destroy
    return unless @author

    @books = @author.books
    @cart.destroy_all if @cart = Cart.find_relcart(@books.ids)
    @books&.destroy_all
    @author.destroy
    redirect_to admin_authors_path
  end

  private

  def author_params
    params.require(:author).permit(:name, :email, :info)
  end

  def find_author
    @author = Author.find_by(params[:id])
    return if @author

    flash[:danger] = 'error'
    redirect_to authors_path
  end
end
