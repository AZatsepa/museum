class AddIndexes < ActiveRecord::Migration[5.0]
  def change
    add_index :comments, :user_id
    add_index :comments, :post_id
    add_index :posts, :user_id
  end
end
