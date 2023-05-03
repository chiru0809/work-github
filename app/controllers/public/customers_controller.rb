class Public::CustomersController < ApplicationController
  def show
  end

  def edit
  end
  
  def update
    @customer = Customer.find(current_customer.id)
    if @customer.update(customer_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to my_page_path
    else
      render :edit
    end
  end
  
  
  private
  
  def customer_params
    params.require(:customer).permit(:name, :profile_image)
  end
end
