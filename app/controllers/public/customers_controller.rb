class Public::CustomersController < ApplicationController
  def show
  end

  def edit
    @customer = current_customer
  end
  
  def update
    @customer = Customer.find(current_customer.id)
    if @customer.update(customer_params)
      redirect_to my_page_path
    else
      render :edit
    end
  end
  
  def confirm
  end
  
  def cancel
    @customer = Customer.find(current_customer.id)
    @customer.is_deleted = true
    @customer.update(customer_cancel_params)
    reset_session
    redirect_to top_path
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email, :is_deleted, :customer)
  end
  
  def customer_cancel_params
    params.permit(:is_deleted)
  end
end
