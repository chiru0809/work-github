class Public::OrdersController < ApplicationController
  def index
  end

  def new
    @order = Order.new
  end
  
  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
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
    params.require(:order).permit(:payment_method, :status, :postal_code, :address, :shipping_cost, :total_amount)
  end
  
end
