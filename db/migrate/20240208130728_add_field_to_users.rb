class AddFieldToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :allow, :boolean, default: false
  end
end
