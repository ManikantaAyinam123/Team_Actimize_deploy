class CreateAttendances < ActiveRecord::Migration[6.1]
  def change
    create_table :attendances do |t|
      t.date :date
      t.integer :present, array: true, default: []
      t.integer :leave, array: true, default: []
      t.integer :holiday, array: true, default: []
      t.integer :user_id

      t.timestamps
    end
  end
end
