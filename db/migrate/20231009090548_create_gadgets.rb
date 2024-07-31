class CreateGadgets < ActiveRecord::Migration[6.1]
  def change
    create_table :gadgets do |t|
      t.date :date
      t.string :expert_name
      t.string :employee_id
      t.string :designation
      t.string :department
      t.string :reporting_to
      t.string :email_id
      t.string :mobile_number
      t.string :working_location
      t.string :made_by
      t.string :serial_number
      t.string :model
      t.string :color
      t.boolean :charger
      t.boolean :keyboard
      t.boolean :mouse
      t.boolean :bag

      t.timestamps
    end
  end
end
