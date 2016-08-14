class CartsController < ApplicationController
  before_action :set_current_cart

  # Lists all items in the cart
  def show
  end

  # redirects to cart show page on Checkout
  # sets current_cart to nil on checkout
  def checkout
    @current_cart.adjust_inventory
    @current_cart.mark_submited
    current_user.remove_current_cart
    redirect_to cart_path(@current_cart)
  end

  private
  def set_current_cart
    @current_cart = current_user.current_cart
  end

end
