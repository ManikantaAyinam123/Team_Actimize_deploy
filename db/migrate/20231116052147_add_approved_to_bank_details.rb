class AddApprovedToBankDetails < ActiveRecord::Migration[6.1]
  def change
    add_column :bank_details, :approved, :boolean, default: false
  end
end
