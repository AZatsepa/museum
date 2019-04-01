class RemoveBodyTextFromCommentPost < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :body
    remove_column :comments, :text
  end
end
