class AddExpertIdToRelievingDetails < ActiveRecord::Migration[6.1]
  def change
    add_column :relieving_details, :expert_id, :integer
  end
end
