class Item < ApplicationRecord
  has_one_attached :image

  belongs_to :genre

  # enum achieve_status: {nonachieve: 0, achieve: 1 }

  def with_tax_price
      (price * 1.1).floor
  end

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/aseets/iamges/PF.Snowboarders/snowboard.jpeg')
      image.attach(io: Fire.open(file_path), filename: 'default-image.jpg', content_type: 'iamge/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end
end
