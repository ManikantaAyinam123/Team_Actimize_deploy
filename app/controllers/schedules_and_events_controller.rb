class SchedulesAndEventsController < ApplicationController
	before_action :authorize_request

 

  def index
    @schedules_and_events = SchedulesAndEvent.order(created_at: :desc).paginate(page: params[:page], per_page: 3)
    #before pagination apr 24 render json: @schedules_and_events, each_serializer: SchedulesAndEventSerializer
    
    total_count = @schedules_and_events.count
     per_page = 3
  ratio = (total_count.to_f / per_page).ceil

  if @schedules_and_events.empty?
    render json: { message: 'No records found' }, status: :ok
  else

      render json: {
        schedules_and_events: ActiveModel::Serializer::CollectionSerializer.new(
                            @schedules_and_events,
                            each_serializer: SchedulesAndEventSerializer
                          ),
         total_pages: ratio
      }, status: :ok
    end
  end
 

 

  def create
    params.merge!(user_id: @current_user.id) if params.present?
    @schedules_and_event = SchedulesAndEvent.new(schedules_and_event_params)

    if @schedules_and_event.save
      #after that change all like commented code data and errors
      # render json:{ data: @schedules_and_event}, status: :created
      render json: @schedules_and_event, serializer: SchedulesAndEventSerializer, status: :created
    else
       render json: @schedules_and_event.errors, status: :unprocessable_entity
        # render json: { errors: @schedules_and_event.errors}, status: :unprocessable_entity
    end
  end

  def update
     @schedules_and_event = SchedulesAndEvent.find_by_id(params[:id])

    if @schedules_and_event.update(schedules_and_event_params)
      render json: @schedules_and_event, serializer: SchedulesAndEventSerializer, status: :created
    else
      render json: @schedules_and_event.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @schedules_and_event = SchedulesAndEvent.find_by_id(params[:id])
   if @schedules_and_event.destroy
      render json: @schedules_and_event, status: :created
    else
      render json: { errors: "Record not found or deleted" },
             status: :unprocessable_entity
   end    
  end

  private

  def schedules_and_event_params
    params.permit(:id,:event_name, :event_date, :event_time, :venue, :view, :user_id)
  end

  
  
end
