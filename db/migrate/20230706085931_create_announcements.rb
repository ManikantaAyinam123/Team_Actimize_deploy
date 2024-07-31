class CreateAnnouncements < ActiveRecord::Migration[6.1]
  def change
    create_table :announcements do |t|
      t.string :type
      t.string :title
      t.date :date

      t.timestamps
    end
  end
end
