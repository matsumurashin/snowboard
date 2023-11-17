class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer :customer_id, null: false
      t.integer :item_id, null: false
      t.string :comment, null: false
      t.float       :all_stars, null: false, default: 0
      t.float       :star1, null: false, default: 0
      t.float       :star2, null: false, default: 0
      t.float       :star3, null: false, default: 0
      t.float       :star4, null: false, default: 0

      t.timestamps
    end
  end
end
