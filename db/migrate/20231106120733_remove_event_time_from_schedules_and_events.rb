class RemoveEventTimeFromSchedulesAndEvents < ActiveRecord::Migration[6.1]
  def change
    remove_column :schedules_and_events, :event_time
  end
end
