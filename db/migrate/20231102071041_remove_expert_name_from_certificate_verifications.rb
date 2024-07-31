class RemoveExpertNameFromCertificateVerifications < ActiveRecord::Migration[6.1]
  def change
     remove_column :certificate_verifications, :expert_name
  end
end
