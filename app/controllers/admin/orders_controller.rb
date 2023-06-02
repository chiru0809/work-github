class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @customer = Customer.find(@order.customer_id)
    @order_details = OrderDetail.where(order_id: @order.id)
    @total_price = 0
  end
  
  def update
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    if @order.update(order_params)
      @order_details.update_all(making_status: "production_pending") if @order.status == "payment_confirmation"
      redirect_to admin_order_path(@order.id)
    else
      render :show
    end
  end
  
  private
  
  def order_params
    params.require(:order).permit(:status)
  end
  
  def order_detail_params
    params.require(:order).permit(:making_status)
  end
end
