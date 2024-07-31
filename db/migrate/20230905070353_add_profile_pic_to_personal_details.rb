class AddProfilePicToPersonalDetails < ActiveRecord::Migration[6.1]
  def change
    add_column :personal_details, :profile_pic, :string
  end
end
