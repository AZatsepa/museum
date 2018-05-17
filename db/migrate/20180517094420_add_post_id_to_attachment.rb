class AddPostIdToAttachment < ActiveRecord::Migration[5.0]
  def change
    add_column :attachments, :post_id, :integer
    add_index :attachments, :post_id
  end
end
