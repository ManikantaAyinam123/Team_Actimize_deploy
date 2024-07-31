class CreateActivityTrackers < ActiveRecord::Migration[6.1]
  def change
    create_table :activity_trackers do |t|

      t.integer :created_by
      t.string :headings
      t.string :contents
      t.string :app_url
      t.boolean :is_read, default: false
      t.datetime :read_at
      t.boolean :action_needed, default: false
      t.integer :guest_id
      t.string :notification_type
      t.integer :notification_type_id


      t.timestamps
    end
  end
end
