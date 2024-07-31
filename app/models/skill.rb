class Skill < ApplicationRecord
	belongs_to :user
	validates :skill_name,:rating, presence: true
	validates_uniqueness_of :skill_name, scope: :user_id		
end
