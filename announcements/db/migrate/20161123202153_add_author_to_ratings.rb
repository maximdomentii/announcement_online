class AddAuthorToRatings < ActiveRecord::Migration[5.0]
  def change
    add_column :ratings, :author, :string, :default => 'Annonymous'
  end
end
