class StoreController < ApplicationController
  # before_action :authenticate_user!
  def index
    @categories = Category.all
    @items = Item.available_items
  end

end
