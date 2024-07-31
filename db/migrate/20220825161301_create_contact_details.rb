class CreateContactDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :contact_details do |t|
      t.integer :user_id
      t.string :name
      t.string :email
      t.string :mobile_number
      t.string :relationship
      t.string :type
      t.text :address
      t.timestamps
    end
  end
end
