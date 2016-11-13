class CreateRatings < ActiveRecord::Migration[5.0]
  def change
    create_table :ratings do |t|
      t.integer :rank, :default => 0
      t.text :comment
      t.references :announcement, foreign_key: true

      t.timestamps
    end
  end
end
