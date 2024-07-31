class AddEventTimeToSchedulesAndEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :schedules_and_events, :event_time, :datetime
  end
end
