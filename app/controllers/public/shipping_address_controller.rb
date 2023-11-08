class Public::ShippingAddressController < ApplicationController
  def index
    @shipping_address = ShippingAddress.new
    @shipping_addresses = ShippingAddress.all
  end

  def create
    @shipping_address = ShippingAddress.new(shipping_address_params)
    @shipping_address.save
    redirect_to shipping_address_index_path
  end

  def edit
  end

  private

  def shipping_address_params
    params.erquire(:shipping_address).permit(:customer_id, :postal_code, :address, :name)
end
