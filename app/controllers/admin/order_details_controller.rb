class Admin::OrderDetailsController < ApplicationController
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = Order.find(@order_detail.order.id)
    @order_details = @order.order_details.all
    is_updated = true
    if @order_detail.update(order_detail_params)
      @order.update(status: "in_production") if @order_detail.making_status == "in_production"
      @order_details.each do |order_detail|
        if order_detail.making_status != "production_complete"
          is_updated = false
        end
      end
      @order.update(status: "preparing_delivery") if is_updated
      redirect_to admin_order_path(@order_detail.order_id)
    else
      render :show
    end
  end
  
  
  private
  
  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
