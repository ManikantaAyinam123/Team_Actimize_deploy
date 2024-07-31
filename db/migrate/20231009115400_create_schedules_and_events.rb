class CreateSchedulesAndEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :schedules_and_events do |t|
      t.string :event_name
      t.date :event_date
      t.time :event_time
      t.string :venue
      t.text :view

      t.timestamps
    end
  end
end
