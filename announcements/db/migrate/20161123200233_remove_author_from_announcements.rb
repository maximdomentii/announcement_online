class RemoveAuthorFromAnnouncements < ActiveRecord::Migration[5.0]
  def change
    remove_column :announcements, :author, :string
  end
end
