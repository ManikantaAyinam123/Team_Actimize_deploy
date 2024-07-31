class HolidaysController < ApplicationController
  before_action :authorize_request
	
  
  def index
    
    @holidays = Holiday.order(date: :asc).paginate(page: params[:page], per_page: 3)
    # render json: format_holidays(@holidays)

    total_count = @holidays.count
    per_page = 3
  ratio = (total_count.to_f / per_page).ceil

  if @holidays.empty?
    render json: { message: 'No records found' }, status: :ok
  else

      render json: {
        holidays: format_holidays(@holidays),
        total_pages: ratio
      }, status: :ok
      end
  end  
  
  def create
    params.merge!(user_id: @current_user.id) if params.present?
    @holiday = Holiday.new(holiday_params)

    if @holiday.save
      render json: format_holiday(@holiday), status: :created
    else
      render json: @holiday.errors, status: :unprocessable_entity
    end
  end
  
  def show
     @holiday = Holiday.find(params[:id])
    render json: @holiday, status: :ok
  end


	def update
	 params.merge!(user_id: @current_user.id) if params.present?
   	@holidays = Holiday.find(params[:id])

    if @holidays.update(holiday_params)
      render json: @holidays, status: :ok
    else
      render json: @holidays.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @holidays = Holiday.find_by_id(params[:id])
     if @holidays.destroy
        render json: @holidays, status: :created
      else
        render json: { errors: "Record not found or deleted" },
               status: :unprocessable_entity
     end    
  end

  private

  def holiday_params
    params.permit(:title, :date, :user_id)
  end

  def format_holiday(holiday)
    {
      id: holiday.id,
      title: holiday.title,
      date: holiday.date,
      day: holiday.date.strftime('%A'), # Format to get the day
       # user_id: holiday.user_id
    }
  end

  def format_holidays(holidays)
    holidays.map do |holiday|
      format_holiday(holiday)
    end
  end
  
end