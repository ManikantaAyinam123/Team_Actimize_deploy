class BirthdaysController < ApplicationController
  before_action :authorize_request
  # load_and_authorize_resource	
  
 
  
#   def birthday_date  before pagination code apr 24
#     # Fetch all active users
#     active_users = User.active.pluck(:id)

#     # Fetch personal details for active users and order by date of birth
#     personal_detail = PersonalDetail.where(user_id: active_users).order(date_of_birth: :asc).paginate(page: params[:page], per_page: 3)
    
#   # personal_detail = PersonalDetail.all.order(date_of_birth: :asc).paginate(page: params[:page], per_page: 4)
#   birth_date = []

#   personal_detail.each do |date|
#     full_name = "#{date.first_name} #{date.last_name}"

    
#     date_of_birth = Date.parse(date.date_of_birth).strftime("%d-%B")

#   birth_date << {
#       name: full_name,
#       date_of_birth: date_of_birth,
#       profile_pic: date.profile_pic
#     }
#   end

#   render json: birth_date
# end

def birthday_date
  # Fetch all active users
  active_users = User.active.pluck(:id)

  # Fetch personal details for active users and order by date of birth
  personal_details = PersonalDetail.where(user_id: active_users)
                                   .order(date_of_birth: :asc)
                                   .paginate(page: params[:page], per_page: 3)
  
  birth_date = personal_details.map do |detail|
    {
      name: "#{detail.first_name} #{detail.last_name}",
      date_of_birth: Date.parse(detail.date_of_birth).strftime("%d-%B"),
      profile_pic: detail.profile_pic
    }
  end

  # total_count = PersonalDetail.where(user_id: active_users).count

  total_count = personal_details.count
   per_page = 3
  ratio = (total_count.to_f / per_page).ceil
   if birth_date.present?
    render json: {
          birthdays: birth_date,
          total_pages: ratio
        }
      
  else
     render json: { message: 'No records found' }, status: :ok
     end  
  end  


 private

  def birthday_params
    params.permit(:date_of_birth)
  end

end