class ChangeColumnNameInPerformanceAppreciations < ActiveRecord::Migration[6.1]
  def change
      rename_column :performance_appreciations, :expert_name, :name
  end
end
