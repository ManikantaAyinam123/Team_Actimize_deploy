class CreateHoursEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :hours_entries do |t|
      t.integer :user_id
      t.jsonb :weekly_status, null: false, default: '{}'
      t.boolean :approval, default: :false
      t.timestamps
    end
  end
end
