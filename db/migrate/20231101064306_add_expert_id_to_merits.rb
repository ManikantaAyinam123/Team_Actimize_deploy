class AddExpertIdToMerits < ActiveRecord::Migration[6.1]
  def change
    add_column :merits, :expert_id, :integer
  end
end
