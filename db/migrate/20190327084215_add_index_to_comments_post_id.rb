class AddIndexToCommentsPostId < ActiveRecord::Migration[5.2]
  def change
    add_index :comments, :post_id, unique: true
  end
end
