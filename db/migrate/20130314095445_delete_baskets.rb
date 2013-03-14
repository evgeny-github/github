class DeleteBaskets < ActiveRecord::Migration
  def up
    drop_table :baskets
  end

end
