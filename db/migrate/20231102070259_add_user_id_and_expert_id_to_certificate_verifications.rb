class AddUserIdAndExpertIdToCertificateVerifications < ActiveRecord::Migration[6.1]
  def change
    add_column :certificate_verifications, :user_id, :integer
    add_column :certificate_verifications, :expert_id, :integer
  end
end
