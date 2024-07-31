class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|


      t.integer :created_by
      t.string :headings
      t.string :contents
      t.string :app_url
      t.boolean :is_read, default: false
      t.datetime :read_at
      t.integer :user_id, null: false
      t.boolean :action_needed, default: false
      t.integer :expert_id
      t.string :notification_type
      t.integer :notification_type_id

      t.timestamps
    end
  end
end
