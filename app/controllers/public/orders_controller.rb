class Public::OrdersController < ApplicationController
  def index
    @orders = current_customer.orders
    # @order_details = current_customer.order_details
  end

  def new
    @order = Order.new
    @address = Address.new
  end

  def confirm
    if params[:order][:address_id] == "0"
      @order = Order.new(order_params)
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
      @cart_items = current_customer.cart_items
    elsif params[:order][:address_id] == "1"
      @order = Order.new(order_params)
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:order][:address_id] == "2"
      @order = Order.new(order_params)
    end
    @cart_items = current_customer.cart_items
    @total_price = 0
    @shipping_cost = 800
    @total_amount = (@total_price + @shipping_cost)
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.status = 0
    @cart_items = current_customer.cart_items
    if @order.save
      @cart_items.each do |cart_item|
        order_detail = OrderDetail.new
        order_detail.order_id = @order.id
        order_detail.item_id = cart_item.item_id
        order_detail.price = cart_item.item.taxin_price
        order_detail.amount = cart_item.amount
        order_detail.making_status = 0
        order_detail.save
      end
      redirect_to thanks_path
      @cart_items.destroy_all
    else
      @order = Order.new(order_params)
      render :new
    end
  end

  def show
    order = Order.find(params[:id])
  unless order.customer_id == current_customer.id
    redirect_to orders_path
  end
    @total_price = 0
  end

  def thanks
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :shipping_cost, :total_amount )
  end

  def order_detail_params
    params.require(:order_detail).permit(:item_id, :amount)
  end
end