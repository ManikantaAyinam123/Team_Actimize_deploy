class AddExpertIdToPerformanceAppreciations < ActiveRecord::Migration[6.1]
  def change
    add_column :performance_appreciations, :expert_id, :integer
  end
end
