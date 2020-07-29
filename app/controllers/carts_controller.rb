class CartsController < ApplicationController
  before_action :find_cart,except: [:index]
  def detail
    @requests_detail = Request.where(cart_id: @cart_detail.id)
  end
  def index
    @carts = Cart.list.all.paginate(page: params[:page],per_page: 10 )
  end

  def show
    @user = User.find_by(id:params[:user_id])
  end

  def accept
    @cart.update(verify:1)
    redirect_to carts_path
  end

  def decline
    @cart.update(verify:2)
    redirect_to carts_path
  end

  private
  def request_params
    params.require(:request).permit(:number, :dateto)
  end

  def find_cart
    return if @cart =Cart.find_by(id: params[:cart_id])
    flash[:warning] = "User not found"
    redirect_to root_path
  end

  def find_detail_cart
    @cart_detail = Cart.find(params[:id])
  end

  def cart_and_request
    @cart = Cart.find(params['id'])
    @list_requests = Request.where('cart_id = ' + @cart.id.to_s) # lay item tu gio hang co id la ...
  end

  def undo_quantity
    @requests = Request.where('cart_id = ' + @cart.id.to_s)
    @requests.each do |r|
      @book = Book.find(r.book_id)
      @book.update_attributes(quantity: @book.quantity + r.number)
    end
    @cart.verify = 2
  end
end
