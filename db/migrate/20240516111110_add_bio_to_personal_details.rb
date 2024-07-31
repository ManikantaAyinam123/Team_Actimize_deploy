class AddBioToPersonalDetails < ActiveRecord::Migration[6.1]
  def change
    add_column :personal_details, :bio, :text
  end
end
