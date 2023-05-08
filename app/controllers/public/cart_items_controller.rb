class Public::CartItemsController < ApplicationController
  def index
    @customer = current_customer
    @cart_items = @customer.cart_items
    @total_price = 0
  end
  
  def create
    cart_item = current_customer.cart_items.new(cart_item_params)
    cart_item.save
    redirect_to cart_items_path
  end
  
  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to cart_items_path
    else
      render :index
    end
  end
  
  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end
  
  private
  
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
  
end
