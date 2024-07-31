class CreateBankDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :bank_details do |t|
      t.integer :user_id
      t.string :bank_name
      t.string :account_number
      t.string :ifsc_code
      t.string :branch_name
      t.timestamps
    end
  end
end
