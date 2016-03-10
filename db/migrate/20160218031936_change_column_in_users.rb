class ChangeColumnInUsers < ActiveRecord::Migration
  def change
    rename_column :users, :last_login_at, :last_login_attempt_at
  end
end
