class CartsController < ApplicationController
  before_action :find_user
  before_action :find_cart, only: %i[decline undo_quantity destroy accept]
  before_action :find_detail_cart, only: [:detail]
  before_action :cart_and_request, only: %i[show confirm update_request_params]

  def show
    @requests = @list_requests.order('created_at DESC')
  end

  def detail
    @requests_detail = Request.where(cart_id: @cart_detail.id)
  end

  def my_cart
    @carts = Cart.where("verify not like '3' and user_id" + '= ' + @user.id.to_s).order('created_at DESC') if logged_in?
  end

  def destroy
    undo_quantity
    redirect_to '/my_cart/:id(.:format)' if @cart.destroy
  end

  def update_request_params(dateto, number)
    session[:dateto] = dateto
    session[:number] = number
    book_arr = []
    # session[:number] la mang so luong sach
    check = 0
    @list_requests.each_with_index do |r, dem|
      next unless dateto && number

      book_arr[dem] = Book.find(r.book_id)
      if book_arr[dem].quantity >= session[:number][dem].to_i && session[:dateto][dem].to_date > Time.zone.now.to_date # time zone la ngay hien tai
        r.update_attributes(number: session[:number][dem].to_i, datefrom: Time.zone.now.to_date, dateto: session[:dateto][dem].to_date)
        book_arr[dem].quantity = book_arr[dem].quantity - r.number
      else
        check = 3
        break
      end
    end
    # if verify == 3 return = 0 update quantity
    if check == 0
      book_arr.each_with_index do |b, _index|
        book = Book.find_by(id: b.id)
        book.update_attributes(quantity: b.quantity)
      end
      @cart.update_attributes(verify: 0)
    end
  end

  def confirm # check out
    dateto = params['dateto'] # get dateto tu tren view ve
    number = params['number'] # get number tu tren view ve
    update_request_params dateto, number
    @user.carts.create if @cart.verify == 0
    respond_to do |f|
      f.js
    end
  end

  def accept
    @cart.verify = 1
    redirect_to carts_url if @cart.save
  end

  def decline
    undo_quantity
    redirect_to carts_url if @cart.save
  end

  def index
    @carts = Cart.carts_admin.order('created_at DESC')
  end

  private

  def request_params
    params.require(:request).permit(:number, :dateto)
  end

  def find_user
    @user = current_user
  end

  def find_cart
    @cart = Cart.find(params[:id])
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
