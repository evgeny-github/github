class AddSendToBaskets < ActiveRecord::Migration
  def change
    add_column :baskets, :send_completed, :boolean

  end
end
