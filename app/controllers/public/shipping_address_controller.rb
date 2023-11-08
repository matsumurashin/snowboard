class Public::ShippingAddressController < ApplicationController
  def index
    @shipping_address = ShippingAddress.new
    @shipping_addresses = current_customer.shipping_address.all
  end

  def create
    @shipping_address = ShippingAddress.new(shipping_address_params)
    @shipping_address.customer_id = current_customer.id
    if @shipping_address.save
      redirect_to shipping_address_index_path
    else
      render 'index'
    end
  end

  def edit
    @shipping_address = ShippingAddress.find(params[:id])
  end

  def destroy
    @shipping_address = ShippingAddress.find(params[:id])
    @shipping_address.destroy
    redirect_to shipping_address_index_path
  end

  private

  def shipping_address_params
    params.require(:shipping_address).permit(:customer_id, :postal_code, :address, :name)
  end
end
