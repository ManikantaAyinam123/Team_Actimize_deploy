class AddUserIdToPerformanceAppreciations < ActiveRecord::Migration[6.1]
  def change
    add_column :performance_appreciations, :user_id, :integer
  end
end
