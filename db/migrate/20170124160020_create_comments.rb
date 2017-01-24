class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :post_id
      t.text    :text

      t.timestamps
    end

    change_table :posts do |t|
      t.integer :user_id
    end
  end
end
