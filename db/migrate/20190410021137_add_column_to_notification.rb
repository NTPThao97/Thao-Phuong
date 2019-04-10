class AddColumnToNotification < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :status, :boolean
  end
end
