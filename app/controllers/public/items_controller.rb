class Public::ItemsController < ApplicationController
  def index
  end
  
  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item.id)
    else
      render :new
    end
  end

  def show
  end
  
  private
  
  def item_params
    params.require(:item).permit(:name, :introduction, :price, :is_active)
  end
end
