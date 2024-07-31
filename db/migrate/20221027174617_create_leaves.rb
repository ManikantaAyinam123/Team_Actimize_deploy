class CreateLeaves < ActiveRecord::Migration[6.1]
  def change
    create_table :leaves do |t|
      t.integer :user_id
      t.string :leave_purpose
      t.string :start_date
      t.string :end_date
      t.string :type_of_leave
      t.boolean :approval, default: :false
      t.timestamps
    end
  end
end
