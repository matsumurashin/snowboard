class ShippingAddress < ApplicationRecord
  belongs_to :customer

  def shipping_address_code
    "#{postal_code} #{address} #{name}"
  end
end
