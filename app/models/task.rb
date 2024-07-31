class Task < ApplicationRecord
	belongs_to :user
	validates :daily_status,:task_name,:task_progress,:description,:worked_hours,:total_hours, presence: true
end
