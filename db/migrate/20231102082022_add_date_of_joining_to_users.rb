class AddDateOfJoiningToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :date_of_joining, :date
  end
end
