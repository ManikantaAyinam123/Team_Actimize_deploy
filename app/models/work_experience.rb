class WorkExperience < ApplicationRecord
	belongs_to :user
	validates :organization_name,:designation,:date_of_join,:date_of_end, presence: true
	validates_uniqueness_of :organization_name, scope: :user_id	
end
