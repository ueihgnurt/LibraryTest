module CartsHelper
  # Cart trong khong co request nao
  def cart_empty? cart_id
    @cart = Cart.find_by(id: cart_id)
    @cart.requests.count == 0
  end
end
