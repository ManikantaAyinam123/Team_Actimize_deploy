class ChangeExpertIdToManagerIdInLeaves < ActiveRecord::Migration[6.1]
  def change
        rename_column :leaves, :expert_id, :manager_id

  end
end
