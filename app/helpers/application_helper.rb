module ApplicationHelper
  include Pagy::Frontend

  def cart_id
    @cart = Cart.where(user_id: current_user.id).last if current_user
    if @cart
      if @cart.verify == 3
        @cart.id
      else
        @cart.id + 1
      end
    end
  end

  def cart
    @cart = Cart.where(user_id: current_user.id).last if current_user
    @cart || nil
  end

  def requests
    @cart = cart
    if @cart.nil? || @cart.verify != 3
      nil
    else
      @requests = Request.where(cart_id: @cart.id).order('created_at DESC')
      @requests
    end
  end

  # trang thai cua request
  def check_status(cart)
    if cart.verify == 0
      'Pending'
    elsif cart.verify == 1
      'Accept'
    elsif cart.verify == 2
      'Decline'
    end
end

  # kiem tra xem item co trong gio chua
  def check_item_cart(book_id)
    return if requests.nil?

    check = (book_ids requests).include? book_id
 end

  # Hien danh sach book theo request
  def book_ids(requests)
    return if requests.nil?

    arr = []
    requests.each do |r|
      arr << r.book_id
    end
    arr
   end
end
