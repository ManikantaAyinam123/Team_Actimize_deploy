class Leave < ApplicationRecord
    belongs_to :manager, class_name: 'User', foreign_key: 'manager_id'
	belongs_to :user
	has_many :notifications, as: :notificable
	validates :leave_purpose,:start_date,:end_date,:type_of_leave, presence: true	
 
end
