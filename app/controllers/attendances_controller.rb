class AttendancesController < ApplicationController
    before_action :authorize_request
 

 def index
    
        date = params[:date]
        if date.present?
          @attendance = Attendance.where(date: date)

    if @attendance.present?
      render json: @attendance
    else   
    render json: { message: 'Please enter a valid date' }, status: :ok
    end    

        else
          render json: { errors: "Please provide a date parameter" }, status: :unprocessable_entity
        end
  end



  def create
   params.merge!(user_id: @current_user.id) if params.present?
    date = params[:date] 
    present_user_ids = params[:present] 
    leave_user_ids = params[:leave]
    holiday_user_ids = params[:holiday]   
    @attendance = Attendance.new(attendance_params)
    if @attendance.save
      render json: @attendance, serializer: AttendanceSerializer, status: :created

      # render json: AttendanceSerializer(@attendance), status: :created
    else
      render json: @attendance.errors, status: :unprocessable_entity
    end

  end

  def update
    # binding.pry
    params[:present].present? ? params[:present] : params[:present]= []
    params[:leave].present? ? params[:leave] : params[:leave]= []
    params[:holiday].present? ? params[:holiday] : params[:holiday]= []
    @attendance = Attendance.find(params[:id])

    if @attendance.update(attendance_params)
    render json: @attendance, serializer: AttendanceSerializer, status: :ok
    else
      render json: @attendance.errors, status: :unprocessable_entity
    end
  end


#   def monthly_status
#      year = params[:year].to_i
#      # current_year = Time.now.year
#      month = params[:month].to_i
#      month_name = Date::MONTHNAMES[month]
#      start_date = Date.new(year, month, 1)
#      # start_date = Date.new(year, month)
#      end_date = start_date.end_of_month

    
   
#     attendances = Attendance.where(date: start_date..end_date)
#     expert_ids = attendances.pluck(:present,:leave,:holiday).flatten.uniq.sort
#     experts = User.where(id: expert_ids).all
#     present_days = attendances.pluck(:present).flatten.group_by { |v| v }.map { |k, v| [k, v.size] }.to_h
       
#     leave_days = attendances.pluck(:leave).flatten.group_by { |v| v }.map { |k, v| [k, v.size] }.to_h
#     holiday_days = attendances.pluck(:holiday).flatten.group_by { |v| v }.map { |k, v| [k, v.size] }.to_h
#     monthly_status = []
#     expert_ids.each do |expert|
     
#         present_days[expert].present? ? present_days[expert] : present_days[expert] = 0
#         leave_days[expert].present? ? leave_days[expert] : leave_days[expert] = 0
#         holiday_days[expert].present? ? holiday_days[expert] : holiday_days[expert] = 0        
      

#       expert_status = {
#         expert_id: expert,
#         expert_name: experts.find_by_id(expert).name,
#         present_days: present_days[expert],
#         leave_days: leave_days[expert],
#         holiday_days: holiday_days[expert],
#         working_days_in_month: attendances.count - holiday_days[expert],
#         expert_working_days: present_days[expert] + leave_days[expert]
#       }

#       monthly_status << expert_status
#   end
#     monthly_status = monthly_status.paginate(page: params[:page], per_page: 10)
#   # 
#   render json:  monthly_status
# end
  
  def monthly_status
  year = params[:year].to_i
  month_name = params[:month].to_i
    
  start_date = Date.new(year, month_name)
  end_date = start_date.end_of_month

  

    
  attendances = Attendance.where(date: start_date..end_date)
  expert_ids = attendances.pluck(:present, :leave, :holiday).flatten.uniq.sort
  experts = User.where(id: expert_ids).all
  present_days = attendances.pluck(:present).flatten.group_by { |v| v }.map { |k, v| [k, v.size] }.to_h
  leave_days = attendances.pluck(:leave).flatten.group_by { |v| v }.map { |k, v| [k, v.size] }.to_h
  holiday_days = attendances.pluck(:holiday).flatten.group_by { |v| v }.map { |k, v| [k, v.size] }.to_h
  monthly_status = []

  expert_ids.each do |expert|
    present_days[expert].present? ? present_days[expert] : present_days[expert] = 0
    leave_days[expert].present? ? leave_days[expert] : leave_days[expert] = 0
    holiday_days[expert].present? ? holiday_days[expert] : holiday_days[expert] = 0        

    expert_status = {
      expert_id: expert,
      expert_name: experts.find_by_id(expert).name,
      present_days: present_days[expert],
      leave_days: leave_days[expert],
      holiday_days: holiday_days[expert],
      working_days_in_month: attendances.count - holiday_days[expert],
      expert_working_days: present_days[expert] + leave_days[expert],
      # month_name: month_name
    }

    monthly_status << expert_status
  end
 
  # monthly_status = monthly_status.paginate(page: params[:page], per_page: 10)

  # render json: monthly_status
  monthly_record = monthly_status.paginate(page: params[:page], per_page: 4)

  # render json: monthly_record
  total_count = monthly_record.count
  per_page = 5
  ratio = (total_count.to_f / per_page).ceil
  if monthly_record.present?
   render json: {
      monthly_attendance: monthly_record,
       total_pages: ratio
    } 
  else
render json: { message: 'No records found' }, status: :ok
    
    end
  end

  private

    def attendance_params
      params.permit(:date, :user_id, present: [], leave: [], holiday: [])
    end

end




