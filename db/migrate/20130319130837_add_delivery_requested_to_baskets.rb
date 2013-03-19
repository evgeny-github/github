class AddDeliveryRequestedToBaskets < ActiveRecord::Migration
  def change
    add_column :baskets, :delivery_requested, :boolean

    add_column :baskets, :delivery_completed, :boolean 

  end
end
