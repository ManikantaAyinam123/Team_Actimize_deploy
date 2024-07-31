class AddExpertIdToAttendances < ActiveRecord::Migration[6.1]
  def change
     add_column :attendances, :expert_id, :integer
  end
end

