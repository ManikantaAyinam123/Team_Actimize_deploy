class AddNumberOfLeavesToLeaves < ActiveRecord::Migration[6.1]
  def change
    add_column :leaves, :number_of_leaves, :integer
  end
end
