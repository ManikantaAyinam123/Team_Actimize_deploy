class CreateLeaveBanks < ActiveRecord::Migration[6.1]
  def change
    create_table :leave_banks do |t|
      t.integer :user_id
      t.string :year
      t.string :casual_leaves
      t.string :sick_leaves
      t.string :other_leaves
      t.timestamps
    end
  end
end
