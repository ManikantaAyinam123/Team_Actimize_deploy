class AddExpertIdToLeaveBanks < ActiveRecord::Migration[6.1]
  def change
    add_column :leave_banks, :expert_id, :integer
  end
end
