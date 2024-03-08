class ShippingAddress < ApplicationRecord
  belongs_to :customer

  validates :name, :postal_code, :address, presence: true

  def shipping_address_code
    "#{postal_code} #{address} #{name}"
  end
end