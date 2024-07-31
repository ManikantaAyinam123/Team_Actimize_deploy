class DashboardController < ApplicationController
  
   before_action :authorize_request
   load_and_authorize_resource 


  def manager_dashboard
    birthdays = upcoming_birthdays
    holidays = upcoming_holidays(3)
    render json: {
      birthdays: ActiveModel::Serializer::CollectionSerializer.new(birthdays, serializer: BirthdaySerializer),
      holidays: holidays
       }, status: :ok
  end

   
   def dashboard
    user = @current_user 
    
    birthdays = upcoming_birthdays
    holidays = upcoming_holidays(3)
    working_days = user_working_days(user)

    total_hours_per_day = 8
    
    
  total_hours = working_days.reject { |day| day == "Sunday" ||    day == "Holiday" }.count * total_hours_per_day

    
  total_working_hours = working_days.select { |day| day.is_a?(Integer) }.sum
    not_worked_hours_per_day = working_days.select { |day| day.is_a?(Integer) && day < total_hours_per_day }
                                           .map { |worked_hours| total_hours_per_day - worked_hours }
                                           .reject { |not_worked_hours| not_worked_hours == total_hours_per_day }
    
    total_not_worked_hours = not_worked_hours_per_day.sum

   
    total_leave_days = working_days.count { |day| day == "Leave" }
  total_leave_hours = total_leave_days * total_hours_per_day
    render json: {
      birthdays: ActiveModel::Serializer::CollectionSerializer.new(birthdays, serializer: BirthdaySerializer),
      holidays: holidays,
      working_days: working_days,
      total_hours: total_hours,
      total_working_hours: total_working_hours,
      total_non_worked_hours: total_not_worked_hours,
      total_hours_in_leave: total_leave_hours
    }, status: :ok
  end

 
  def all_users_previous_weeks_totals
   all_users = User.active
    # all_users = User.all.paginate(page: params[:page], per_page: 10)
     # all_users = all_users.paginate(page: params[:page], per_page: 5)
    # .paginate(page: params[:page], per_page: 10)
    num_weeks = 10
    user_totals = []

    num_weeks.times do |week|
      week_totals = []

      all_users.each do |user|
        week_totals.concat(user_previous_weeks_totals(user, week))
      end

      user_totals << week_totals
    end
    
      # user_totals = user_totals.flatten
       # render json: user_totals.flatten, status: :ok
      # render json: user_totals.paginate(page: params[:page], per_page: 5), status: :ok

  # these two line before pagination apr 24
  # paginated_user_totals = user_totals.flatten.paginate(page: params[:page], per_page: 10)
  # render json: paginated_user_totals, status: :ok
  paginated_user_totals = user_totals.flatten.paginate(page: params[:page], per_page: 6)
  
total_count = paginated_user_totals.count
per_page = 5
  ratio = (total_count.to_f / per_page).ceil

   
   if paginated_user_totals.present?
   render json: {
      previous_weeks: paginated_user_totals,
      total_pages: ratio
    }, status: :ok 
  else
    render json: { message: 'No records found' }, status: :ok
    
    # render json: paginated_user_totals, status: :ok
    end
  end  


  # def all_users_previous_month_totals
  #   all_users = User.all.paginate(page: params[:page], per_page: 10)
  #   user_totals = []

    
  #   month_name = params[:month]
  #   year = params[:year]

  #   all_users.each do |user|
  #     user_totals.concat(user_previous_month_totals(user, month_name, year))
  #   end

  #   render json: user_totals, status: :ok
  # end

  def all_users_previous_month_totals
  all_users = User.all.paginate(page: params[:page], per_page: 10)
  user_totals = []

  month_name = params[:month]
  year = params[:year]

  all_users.each do |user|
    user_totals.concat(user_previous_month_totals(user, month_name, year))
  end
# this below line before pagination apr 24
  # render json: user_totals, status: :ok

  total_count = all_users.count
  per_page = 10
  ratio = (total_count.to_f / per_page).ceil
    
  
  if user_totals.present?
    render json: {
        monthly_status: user_totals,
       total_pages: ratio
      }, status: :ok
  else
     render json: { message: 'No records found' }, status: :ok
      # render json: user_totals, status: :ok
     

      end
  end 



  def upcoming_birthdays

    pds = PersonalDetail.all
    sorted_results = []
      pds.each do|pd|
       pd.date_of_birth = pd.date_of_birth.to_date.strftime("%d %B").to_datetime
      end 
    pds = pds.sort_by(&:date_of_birth)
        
    if (pds.last.date_of_birth.to_datetime >= Date.today)

      pds.each do|pd|
        if (pd.date_of_birth.to_datetime >= Date.today)
           sorted_results << pd
        end  
      end

    else
        pds.first(3).each do |pd|
           if (pd.date_of_birth.to_datetime.next_year >= Date.today)
            sorted_results << pd
            end
        end
    end
    next_birthdays = sorted_results.pluck(:id).first(3)
  
    pds.last.date_of_birth.to_datetime >= Date.today
    birthdays = next_birthdays.map { |id| PersonalDetail.find(id) }
    
  end

  def upcoming_holidays(count)
     
      upcoming_holidays = Holiday.where('date >= ?', Date.today)
                                 .order(:date)
                                 .limit(count)
      upcoming_holidays.map do |holiday|
        { title: holiday.title, date: holiday.date.strftime('%d-%m-%Y') }
      end
  end


  def user_previous_weeks_totals(user, week)
    all_weeks_totals = []

    end_date = week.weeks.ago.at_end_of_week
    start_date = end_date.at_beginning_of_week

    
    formatted_start_date = start_date.strftime('%Y-%m-%d')
    formatted_end_date = end_date.strftime('%Y-%m-%d')

    working_days = user_previous_weeks_work_days(user, start_date, end_date)
    total_hours_per_day = 8

    total_hours = working_days.reject { |day| day == "Sunday" || day == "Holiday" }.count * total_hours_per_day
    total_working_hours = working_days.select { |day| day.is_a?(Integer) }.sum

    not_worked_hours_per_day = working_days.select { |day| day.is_a?(Integer) && day < total_hours_per_day }
      .map { |worked_hours| total_hours_per_day - worked_hours }
      .reject { |not_worked_hours| not_worked_hours == total_hours_per_day }

    total_not_worked_hours = not_worked_hours_per_day.sum

    total_leave_days = working_days.count { |day| day == "Leave" }
    total_leave_hours = total_leave_days * total_hours_per_day

    all_weeks_totals << {
      name: user.name,
      employee_id: user.employee_id_number,
      start_date: formatted_start_date,
      end_date: formatted_end_date,
      total_hours: total_hours,
      total_working_hours: total_working_hours,
      total_non_worked_hours: total_not_worked_hours,
      total_hours_in_leave: total_leave_hours
    }

    all_weeks_totals
  end

  def user_daily_status
    
    name = params[:name]
    start_date = params[:start_date]

    
    user = User.find_by(name: name)

    if user.nil?
      render json: { error: 'User not found' }, status: :unprocessable_entity
      return
    end

    
    daily_status = user_daily_status_for_week(user, start_date)

    render json: { name: name, start_date: start_date, daily_status: daily_status }, status: :ok
  end



  def user_working_days(user)
    

  
    start_date = Date.today.prev_month.at_beginning_of_month
    end_date = Date.today.prev_month.at_end_of_month
    hours_entries = @current_user.hours_entries.where('week_start_date >= ? AND week_start_date <= ?', start_date.at_beginning_of_week, end_date.at_end_of_week).pluck(:weekly_status)
    he = hours_entries.flat_map(&:values)
        result = []

     (start_date..end_date).each do |day|    

      result[day.day-1] = 0

          if day.strftime("%A") == "Sunday"            
                result[day.day-1] = "Sunday"  
          else 
              he.each do |p_day|
                if p_day["Date"].to_datetime == day
                  if p_day["Hours"].present?
                   result[day.day-1] = p_day["Hours"].to_i
                  end
                  if p_day["Day"].present?
                   result[day.day-1] = p_day["Day"]
                  end                  
                end 
              end            
          end  

      end
   return result
  end

 def user_previous_weeks_work_days(user, start_date, end_date)
    hours_entries = user.hours_entries.where('week_start_date >= ? AND week_start_date <= ?', start_date, end_date).pluck(:weekly_status)
    he = hours_entries.flat_map(&:values)
    result = []
    (start_date.to_date..end_date.to_date).each do |day|
      if day.strftime("%A") == "Sunday"
        result << "Sunday"
      else
        entry = he.find { |p_day| p_day["Date"].to_date == day }
        if entry
          if entry["Hours"].present?
            result << entry["Hours"].to_i
          elsif entry["Day"].present?
            # result << "Leave"
            result << entry["Day"]
          else
            result << nil
          end
        else
          result << nil
        end
      end
    end

    result
  end
  

  def user_previous_month_totals(user, month_name, year)
  all_month_totals = []

  month_number = Date::MONTHNAMES.index(month_name.capitalize)

  return all_month_totals unless month_number

  first_day_of_month = Date.new(year.to_i, month_number)
  last_day_of_month = first_day_of_month.end_of_month

  working_days = user_previous_month_work_days(user, first_day_of_month, last_day_of_month)
  total_hours_per_day = 8

  total_hours = working_days.reject { |day| day == "Sunday" || day == "Holiday" }.count * total_hours_per_day
  total_working_hours = working_days.select { |day| day.is_a?(Integer) }.sum

  not_worked_hours_per_day = working_days.select { |day| day.is_a?(Integer) && day < total_hours_per_day }
    .map { |worked_hours| total_hours_per_day - worked_hours }
    .reject { |not_worked_hours| not_worked_hours == total_hours_per_day }

  total_not_worked_hours = not_worked_hours_per_day.sum

  total_leave_days = working_days.count { |day| day == "Leave" }
  total_leave_hours = total_leave_days * total_hours_per_day

  all_month_totals << {
    # user_id: user.id
    name: user.name,
    employee_id: user.employee_id_number,
    start_date: first_day_of_month,
    end_date: last_day_of_month,
    total_hours: total_hours,
    total_working_hours: total_working_hours,
    total_non_worked_hours: total_not_worked_hours,
    total_hours_in_leave: total_leave_hours
  }

  all_month_totals
end

  def user_previous_month_work_days(user, start_date, end_date)
    hours_entries = user.hours_entries.where('week_start_date >= ? AND week_start_date <= ?', start_date, end_date).pluck(:weekly_status)
    he = hours_entries.flat_map(&:values)
    result = []

    (start_date.to_date..end_date.to_date).each do |day|
      if day.strftime("%A") == "Sunday"
        result << "Sunday"
      else
        entry = he.find { |p_day| p_day["Date"].to_date == day }
        if entry
          if entry["Hours"].present?
            result << entry["Hours"].to_i
          elsif entry["Day"].present?
            result << "Leave"
          else
            result << nil
          end
        else
          result << nil
        end
      end
    end

    result
  end


  
  def user_daily_status_for_week(user, start_date)
    start_date = start_date.to_date
    end_date = start_date + 6.days
    working_days = user_previous_weeks_work_days(user, start_date, end_date)
    formatted_status = working_days.map do |status|
      if status.is_a?(Integer)
      # if status.to_i.is_a?(Integer)
      # if status.present? && status.to_i.is_a?(Integer)

      # binding.pry
        # "Date - #{start_date.strftime('%d-%m-%Y')} hours - #{status}"
        {date: start_date.strftime('%d-%m-%Y'),hours: status}
      elsif status == "Leave"
        # "Date - #{start_date.strftime('%d-%m-%Y')} Day - Leave"
                {date: start_date.strftime('%d-%m-%Y'),day: status}

      elsif status == "Holiday"
        # "Date - #{start_date.strftime('%d-%m-%Y')} Day - Holiday"
                {date: start_date.strftime('%d-%m-%Y'),day: status}

      elsif status == "Sunday"
        # "Date - #{start_date.strftime('%d-%m-%Y')} Day - Sunday"
                {date: start_date.strftime('%d-%m-%Y'),day: "Sunday"}

      else
        # "Date - #{start_date.strftime('%d-%m-%Y')} hours - 0"
      {date: start_date.strftime('%d-%m-%Y'),day: 0}

      end.tap { start_date += 1.day }
    end

    formatted_status
  end

end



