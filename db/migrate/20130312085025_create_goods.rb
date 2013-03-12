class CreateGoods < ActiveRecord::Migration
  def change
    create_table :goods do |t|
      t.string :title
      t.integer :count
      t.integer :price

      t.timestamps
    end
  end
end
