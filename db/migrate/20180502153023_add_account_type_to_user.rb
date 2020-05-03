class AddAccountTypeToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :account_type, :integer, default: 0
    add_index :authenticates, %i[provider uid]
  end
end
