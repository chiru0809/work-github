class Public::ItemsController < ApplicationController
  def index
    @items = params[:genre_id].present? ? Genre.find(params[:genre_id]).items.page(params[:page]).per(8) : Item.all.page(params[:page]).per(8)
    @genres = Genre.all
    @genre = params[:genre_id].present? ? Genre.find(params[:genre_id]).name : "商品"
    @count = params[:genre_id].present? ? Genre.find(params[:genre_id]).items.count : Item.all.count
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @cart_items = CartItem.new
  end

end
