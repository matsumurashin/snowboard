class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :shipping_address, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :comments, dependent: :destroy

def full_name
  self.first_name + " " + self.last_name
end

def full_name_kana
  self.first_name_kana + " " + self.last_name_kana
end

def self.guest
    find_or_create_by!(email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.name = "ゲスト"
      customer.name_kana = "げすと"
      customer.is_deleted = false
    end
end

end
