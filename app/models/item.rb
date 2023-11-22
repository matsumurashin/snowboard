class Item < ApplicationRecord
  has_one_attached :images

  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  has_many :comments, dependent: :destroy

  def with_tax_price
      (price * 1.1).floor
  end

  # def get_image(width, height)
  #   ActiveRecord::Base.connection.execute("BEGIN TRANSACTION")
  #   unless images.attached?
  #     file_path = Rails.root.join('app/assets/images/snowboard.jpg')
  #     images.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  #   end
  #   images.variant(resize_to_limit: [width, height]).processed
  # end


  def get_image(width, height)
    unless images.attached?
      file_path = Rails.root.join('app/assets/images/snowboard.jpg')
  
      # # トランザクションの開始前にデータベースのロックを解除する
      # ActiveRecord::Base.connection.execute("COMMIT")
  
      # トランザクション内での処理を行う
      ActiveRecord::Base.transaction do
        images.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      end
  
      # # トランザクションの終了後に再びデータベースをロックする
      # ActiveRecord::Base.connection.execute("BEGIN TRANSACTION")
    end
  
    images.variant(resize_to_limit: [width, height]).processed
  end

end
