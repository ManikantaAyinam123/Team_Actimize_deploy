class RenameAllowColumnInUsers < ActiveRecord::Migration[6.1]
  def change
      rename_column :users, :allow, :notifications_allow
  end
end
