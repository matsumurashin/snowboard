class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.find(current_customer.id)
  end

  def edit
    @customer = Customer.find(currnet_customer.id)
  end
  
  def update
    @customer = Customer.find(currnet_customer.id)
    @customer.update(params_customer)
    redirect_to customers_mypage_path
  end

  def check
  end

  private

  def customer_params
    params.require(:customer).permit(:email, :first_name, :last_name, :first_name_kana, :last_name_kana, :postal_code, :address, :telephone_number, :is_deleted)
  end
end
