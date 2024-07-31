class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.integer :user_id
      t.string :daily_status
      t.string :task_name
      t.string :task_progress
      t.string :description
      t.integer :worked_hours 
      t.integer :total_hours  
     
      t.timestamps
    end
  end
end
