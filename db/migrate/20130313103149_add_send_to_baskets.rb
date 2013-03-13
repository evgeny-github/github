class AddSendToBaskets < ActiveRecord::Migration
  def change
    add_column :baskets, :send, :boolean

  end
end
