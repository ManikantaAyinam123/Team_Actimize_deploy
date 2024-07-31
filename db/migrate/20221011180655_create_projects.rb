class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.integer :user_id
      t.string :project_name
      t.string :status
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
