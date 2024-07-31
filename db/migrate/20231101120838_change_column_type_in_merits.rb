class ChangeColumnTypeInMerits < ActiveRecord::Migration[6.1]
  def change
     rename_column :merits, :type, :merit_type
  end
end
