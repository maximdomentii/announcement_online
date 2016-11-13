class CreateAnnouncements < ActiveRecord::Migration[5.0]
  def change
    create_table :announcements do |t|
      t.string :author, :default => 'Anonymous'
      t.string :title
      t.text :description
      t.date :valid_to, :default => Date.tomorrow
      t.integer :clicks, :default => 0
      t.references :category, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
