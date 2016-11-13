class ChangeDefaultValueForValidToAnnouncement < ActiveRecord::Migration[5.0]
  def change
    change_column_default :announcements, :valid_to, nil
  end
end
