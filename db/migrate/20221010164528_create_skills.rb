class CreateSkills < ActiveRecord::Migration[6.1]
  def change
    create_table :skills do |t|
      t.integer :user_id
      t.string :skill_name
      t.float :rating
      t.timestamps
    end
  end
end
