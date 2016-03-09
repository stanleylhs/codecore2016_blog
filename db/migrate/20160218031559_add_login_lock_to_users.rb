class AddLoginLockToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_login_at, :datetime
    add_column :users, :failed_login_count, :integer
  end
end
