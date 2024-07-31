class AddWeekStartDateToHoursEntries < ActiveRecord::Migration[6.1]
  def change
    add_column :hours_entries, :week_start_date, :date
  end
end
