class CreateCertificateVerifications < ActiveRecord::Migration[6.1]
  def change
    create_table :certificate_verifications do |t|
      t.string :expert_name
      t.text :message
      t.text :note

      t.timestamps
    end
  end
end
