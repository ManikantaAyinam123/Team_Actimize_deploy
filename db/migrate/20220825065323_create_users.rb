class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :name
      t.string :username
      t.string :designation
      t.string :employee_id_number
      t.string :roles, array: true, default: []

      t.timestamps
    end
  end
end
