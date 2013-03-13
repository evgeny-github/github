class AddSendDateToBaskets < ActiveRecord::Migration
  def change
    add_column :baskets, :send_date, :datetime

  end
end
