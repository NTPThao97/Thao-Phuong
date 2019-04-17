class CreateDecentralizations < ActiveRecord::Migration[5.2]
  def change
    create_table :decentralizations do |t|
      t.string :name
      t.string :describe
      t.integer :number_account
      t.boolean :active

      t.timestamps
    end
  end
end
