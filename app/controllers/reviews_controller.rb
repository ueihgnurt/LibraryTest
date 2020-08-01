class ReviewsController < ApplicationController
  before_action :set_review, only: %i[show edit update destroy]
  # before_action :logged_in_user

  def new
    @review = Review.new(book_id: params[:book_id],user_id: current_user.id)
  end

  def create
      @review = Review.new(review_params)
      @review.user_id = session[:user_id]
      @book = Book.find(@review.book_id)
      if @review.save
        redirect_to @book
      else
        # render 'new'
        redirect_to @book
      end
  end

  def update
    if @review.update_attributes(review_params)
      @book  = Book.find(@review.book_id)
     @user = User.find(@review.user_id)
  
    flash[:success] = I18n.t("Comment updated")
    redirect_to @book
    else 
      render "edit"
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    @book  = Book.find(@review.book_id)
    redirect_to @book
  end

  private
  def review_params
    params.require(:review).permit(:rating, :comment, :user_id , :book_id)
  end

  def set_review
    @review = Review.find_by(id: params[:id])
  end
end
