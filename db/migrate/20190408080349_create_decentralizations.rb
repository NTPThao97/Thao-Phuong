class CreateDecentralizations < ActiveRecord::Migration[5.2]
  def change
    create_table :decentralizations do |t|
      t.text :name
      t.text :describe
      t.integer :number_acount
      t.boolean :active

      t.timestamps
    end
  end
end
