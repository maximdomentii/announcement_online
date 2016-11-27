class AddPriceValueToAnnouncements < ActiveRecord::Migration[5.0]
  def change
    add_column :announcements, :price_value, :integer
  end
end
