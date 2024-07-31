class CreatePersonalDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :personal_details do |t|
      t.integer :user_id
      t.string :first_name
      t.string :last_name
      t.string :date_of_birth
      t.string :gender
      t.string :nationality
      t.string :marital_status
      t.string :mobile_number
      t.string :aadhar_card_number
      t.string :pan_card_number
      t.string :company_email
      t.string :personal_email
      t.text :present_address
      t.text :permanent_address
      t.timestamps
    end
  end
end
