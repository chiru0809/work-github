class Admin::HomesController < ApplicationController
  def top
    @orders = params[:customer_id].present? ? Customer.find(params[:customer_id]).orders.page(params[:page]).per(10) : Order.all.page(params[:page]).per(10)
    @customer = params[:customer_id].present? ? Customer.find(params[:customer_id]).last_name + Customer.find(params[:customer_id]).first_name + "さんの" : ""
    @order_amount = 0
  end
end
