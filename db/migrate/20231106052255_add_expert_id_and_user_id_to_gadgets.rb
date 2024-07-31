class AddExpertIdAndUserIdToGadgets < ActiveRecord::Migration[6.1]
  def change
     add_column :gadgets, :expert_id, :integer
     add_column :gadgets, :user_id, :integer
  end
end
