class LeaveBank < ApplicationRecord
	  belongs_to :expert, class_name: 'User', foreign_key: 'expert_id'
     belongs_to :user
	 
	 validates :year,:casual_leaves,:sick_leaves,presence: true

	 validates_uniqueness_of :expert_id, scope: :year 



end
