class HoursEntry < ApplicationRecord
	belongs_to :user
	validates :weekly_status, presence: true	
end



