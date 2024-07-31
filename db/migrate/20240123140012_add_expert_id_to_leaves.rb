class AddExpertIdToLeaves < ActiveRecord::Migration[6.1]
  def change
    add_column :leaves, :expert_id, :integer
  end
end
