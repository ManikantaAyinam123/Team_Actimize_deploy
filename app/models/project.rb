class Project < ApplicationRecord
    belongs_to :user
	has_and_belongs_to_many :assigned_users, join_table: 'user_projects',class_name: 'User'
	has_many :notifications, as: :notificable
	validates :project_name,:status, presence: true
	validates_uniqueness_of :project_name
		
		
end
