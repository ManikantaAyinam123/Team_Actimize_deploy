class Attendance < ApplicationRecord

	# belongs_to :user, class_name: 'User', foreign_key: 'user_id'
    belongs_to :user

      # belongs_to :expert

    
    validates_uniqueness_of :date, scope: :user_id

     scope :monthly_attendance, ->(start_date, end_date) {
    where(date: start_date..end_date)
  }

  #   attribute :present, :boolean
  # attribute :leave, :boolean
  # attribute :holiday, :boolean

  
end
	