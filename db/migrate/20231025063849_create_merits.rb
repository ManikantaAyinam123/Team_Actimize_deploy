class CreateMerits < ActiveRecord::Migration[6.1]
  def change
    create_table :merits do |t|
      t.string :type
      t.text :reason
      t.integer :seviority
      t.integer :user_id

      t.timestamps
    end
  end
end
