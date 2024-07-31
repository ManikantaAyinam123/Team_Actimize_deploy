class AddUserIdToActivityTracker < ActiveRecord::Migration[6.1]
  def change
    add_column :activity_trackers, :user_id, :integer
  end
end
