class AddStatusToCertificateVerifications < ActiveRecord::Migration[6.1]
  def change
    add_column :certificate_verifications, :status, :string
  end
end


