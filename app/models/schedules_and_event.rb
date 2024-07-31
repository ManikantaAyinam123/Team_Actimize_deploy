class SchedulesAndEvent < ApplicationRecord
	belongs_to :user
  validates_uniqueness_of :event_name

  def formatted_event_time
    event_time&.strftime("%I:%M%p")
  end
end
