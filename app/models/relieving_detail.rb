class RelievingDetail < ApplicationRecord
	belongs_to :expert, class_name: 'User', foreign_key: 'expert_id'
    belongs_to :user
	validates :start_date, presence: true
    validates :end_date, presence: true
    validates :exit_type, presence: true

end
