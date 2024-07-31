class RemoveExpertNameFromGadgets < ActiveRecord::Migration[6.1]
  def change
     remove_column :gadgets, :expert_name
  end
end
