class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.text :post_text
      t.string :shoot_date
      t.string :shoot_time
      t.string :shoot_address

      t.timestamps
    end
  end
end
