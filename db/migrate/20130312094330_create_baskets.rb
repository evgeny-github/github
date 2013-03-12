class CreateBaskets < ActiveRecord::Migration
  def change
    create_table :baskets do |t|
      t.integer :user_id
      t.integer :good_id
      t.integer :count
      t.integer :price

      t.timestamps
    end
  end
end
