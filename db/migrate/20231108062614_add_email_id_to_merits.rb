class AddEmailIdToMerits < ActiveRecord::Migration[6.1]
  def change
     add_column :merits, :company_email_id, :string
  end
end
