class Admin::HomesController < ApplicationController
  def top
    @orders = Order.all.page(params[:page]).per(10)
    @order_amount = 0
  end
end
