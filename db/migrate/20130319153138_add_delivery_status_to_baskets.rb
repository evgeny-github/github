class AddDeliveryStatusToBaskets < ActiveRecord::Migration
  def change
    add_column :baskets, :delivery_status, :string

  end
end
