class RenameExpertIdToGuestIdInNotifications < ActiveRecord::Migration[6.1]
  def change
     rename_column :notifications, :expert_id, :guest_id
  end
end
