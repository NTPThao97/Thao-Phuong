class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :target_id
      t.string :target_type
      t.integer :des_id
      t.string :des_type
      t.integer :url
      t.datetime :opened_at
      t.boolean :status

      t.timestamps
    end
  end
end
