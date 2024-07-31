class CreateRelievingDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :relieving_details do |t|
      t.integer :user_id
      t.datetime :start_date
      t.datetime :end_date
      t.text :exit_type

      t.timestamps
    end
  end
end
