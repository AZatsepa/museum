class AddRoleToUser < ActiveRecord::Migration[5.0]
  def up
    add_column :users, :role, :integer, default: 0
    User.all.each do |user|
      user.role = user.account_type
      user.save! validate: false
    end
    remove_column :users, :account_type
  end

  def down
    add_column :users, :account_type, :integer, default: 0
    User.all.each do |user|
      user.account_type = user.role_before_type_cast
      user.save! validate: false
    end
    remove_column :users, :role
  end
end
