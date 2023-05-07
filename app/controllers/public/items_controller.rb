class Public::ItemsController < ApplicationController
  def index
    @items = Item.all.page(params[:page]).per(10)
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @tax_included_price = @item.price * 1.1
    @genres = Genre.all
    @cart_items = CartItem.new
  end

end
