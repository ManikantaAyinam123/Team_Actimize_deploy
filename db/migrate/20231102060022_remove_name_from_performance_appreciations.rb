class RemoveNameFromPerformanceAppreciations < ActiveRecord::Migration[6.1]
  def change
    remove_column :performance_appreciations, :name, :string
  end
end
