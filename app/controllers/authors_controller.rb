class AuthorsController < ApplicationController
  before_action :find_author, only: [:show ]

  def new
    @author = Author.new
  end

  def index
    @search = !params[:keyword].nil? ? Author.where('lower(name) LIKE ?', "%#{params[:keyword]}%") : Author.all
    @pagy, @authors = pagy(@search.order('created_at DESC'), items: 9)
  end

  def show
    @q = Author.search(params[:q])
    @search = @q.result(distinct: true)
    @books = @author.books
    @authors = Author.all
  end

  private

  def author_params
    params.require(:author).permit(:name, :email, :info)
  end

  def find_author
    @author = Author.find(params[:id])
    return if @author

    flash[:danger] = 'error'
    redirect_to authors_path
  end
end
