class AddPriceCurrencyToAnnouncements < ActiveRecord::Migration[5.0]
  def change
    add_column :announcements, :price_currency, :string
  end
end
