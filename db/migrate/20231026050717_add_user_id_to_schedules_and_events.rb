class AddUserIdToSchedulesAndEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :schedules_and_events, :user_id, :integer
  end
end
