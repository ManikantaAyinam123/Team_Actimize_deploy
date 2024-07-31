class CreateWorkExperiences < ActiveRecord::Migration[6.1]
  def change
    create_table :work_experiences do |t|
      t.integer :user_id
      t.string :organization_name
      t.string :designation
      t.string :date_of_join      
      t.string :date_of_end

      t.timestamps
    end
  end
end
