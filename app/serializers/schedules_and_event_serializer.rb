class SchedulesAndEventSerializer < ActiveModel::Serializer
  
  attributes :id, :event_name, :event_date, :venue, :view, :created_at, :updated_at, :user_id, :event_time

  def event_time
    object.formatted_event_time
  end
end
