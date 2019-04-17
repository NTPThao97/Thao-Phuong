class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.integer :user_type
      t.string :avatar
      t.integer :status
      t.string :remember_digest

      t.timestamps
    end
  end
end
