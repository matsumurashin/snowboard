class Public::OrdersController < ApplicationController
  def new
   @order = Order.new
   @customer = current_customer
   @shipping_address = current_customer.shipping_address
  end

  def create
  end

  def confirm
  end

  def complete
  end

  def index
  end

  def show
  end

  private

  def order_params
    params.require(order).permit(:payment_method, :status, :name, :postal_code, :address, :shipping_fee, :amont_billed)
  end

  def shipping_address_params
    params.require(:shipping_address).permit(:customer_id, :postal_code, :address, :name)
  end
end
