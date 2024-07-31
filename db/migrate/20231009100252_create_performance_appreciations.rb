class CreatePerformanceAppreciations < ActiveRecord::Migration[6.1]
  def change
    create_table :performance_appreciations do |t|
      t.string :expert_name
      t.date :appreciation_date
      t.text :message

      t.timestamps
    end
  end
end
