class AddSearchableBodyToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :searchable_body, :text
  end
end
