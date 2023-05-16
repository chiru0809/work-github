class Public::OrdersController < ApplicationController
  def index
  end

  def new
    @order = Order.new
    @address = Address.new
  end

  def confirm
    @order = Order.new(order_params)
    @address = Address.find(params[:order][:address_id])
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.last_name + current_customer.first_name
    @cart_items = current_customer.cart_items
    @total_price = 0
    @shipping_cost = 800
    @total_amount = (@total_price + @shipping_cost)
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    # if @order.payment_method
    @order.status = 
    @cart_items = current_customer.cart_items
    @cart_items.each do |cart_item|
      @order = OrderDetail.new(order_detail_params)
    end
    if @order.save
      redirect_to thanks_path
    else
      render :new
    end
  end

  def show
  end

  def thanks
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :shipping_cost, :total_amount )
  end
  
  def order_detail_params
    params.require(:order_detail).permit(:amount)
  end
end