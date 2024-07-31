class Merit < ApplicationRecord
	 belongs_to :expert,class_name: 'User', foreign_key: 'expert_id'
	 belongs_to :user
	 validates :merit_type, presence: true
	 validates :reason, presence: true
	 validates :seviority, presence: true
	  
 
end
