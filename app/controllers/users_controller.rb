class UsersController < ApplicationController
  # load_and_authorize_resource
   # before_action :authorize_request
  	

  # GET /users
   # def index
   #  	exclude_columns = ['password_digest', 'roles', 'created_at','updated_at']
   #  	columns = User.attribute_names - exclude_columns	
   #    @users = User.select(columns)  
   #    render json: @users, status: :ok
   # end

   def index
      exclude_columns = ['password_digest',  'created_at','updated_at']
      columns = User.attribute_names - exclude_columns  
      @users = User.select(columns).active  
      render json: @users, status: :ok
   end

  

  def search_by_name
    # binding.pry
  if params[:name].present?
    @users = User.where('name LIKE ?', "%#{params[:name]}%").select(:id, :name, :email, :designation)
    @user_profiles = @users.map do |user|
      personal_detail = user.personal_detail
      user.as_json(only: [:name, :email, :designation]).merge(
        profile_pic: personal_detail&.profile_pic
      )
    end

    if @user_profiles.present?
      render json: @user_profiles
    else
      render json: { message: "No results found" }
    end
  else
    render json: { message: "Please provide a name parameter" }
  end
end

 # def user_profiles
      
 #  @users = User.select(:id, :name, :designation, :email)
 #               .order(created_at: :desc)
                
 #  # render json: @users.as_json(only: [:name, :designation, :email, :profile_pic])
 #  render json: @users  
 # end


 def user_profiles
      
  @users = User.select(:id, :name, :designation, :gender, :email, 'personal_details.profile_pic')
               .joins(:personal_detail)
               .order(created_at: :desc)
               .active
                .paginate(page: params[:page], per_page: 9)
  # render json: @users.as_json(only: [:name, :designation, :email, :profile_pic])
  # render json: @users  before pagination apr 24
     total_count = @users.count
     per_page = 9
  ratio = (total_count.to_f / per_page).ceil
   if @users.empty?
    render json: { message: 'No records found' }, status: :ok
  else
     render json: {
    users: @users,
   total_pages: ratio
  }, status: :ok   
 end
end


def management
 
  @users = User.select(:name, :id, :username )
              .where("('Management' = ANY (roles))")
              .order(created_at: :desc)
  render json: @users.as_json(only: [:name, :id, :username])
end

def user_name
  @users = User.select(:name, :id, :username).active.order(created_at: :desc)
  
  # render json: @users
  render json: @users.as_json(only: [:name, :id, :username])
end


 

   def personal_details
      @user = User.find(params[:id])
      @personal_detail = @user.personal_detail
      if @personal_detail.present?
    render json: @personal_detail, status: :ok
  else
      
      render json: { message: 'No records found' }, status: :ok
   end
   end

   def emergency_details
      @user = User.find(params[:id])
      @emergency_details = @user.emergency_details
      if @emergency_details.empty?
    render json: { message: 'No records found' }, status: :ok
  else
      render json: @emergency_details, status: :ok
   end
  end 
   def family_details
      @user = User.find(params[:id])
      @family_details = @user.family_details
       if @family_details.present?
    render json: @family_details, status: :ok
  else
      
      render json: { message: 'No records found' }, status: :ok
   end
  end 
   def projects  
      # @user = User.find(params[:id])
      # @projects = @user.projects
      # render json: @projects.as_json(only: [:project_name, :status, :start_date, :end_date, :assigned_by]), status: :ok
  @user = User.find(params[:id])
  @assigned_projects = @user.assigned_projects
   if @assigned_projects.empty?
    render json: { message: 'No records found' }, status: :ok
  else

  render json: @assigned_projects.as_json(only: [:project_name, :status, :start_date, :end_date]), status: :ok
   end
 end

#   def projects
#   @user = User.find(params[:id])
#   @assigned_projects = @user.assigned_projects.order(created_at: :desc)
#                                             .paginate(page: params[:page], per_page: 4)
#   total_count = @assigned_projects.total_entries

#   render json: {
#     assigned_projects: @assigned_projects.as_json(only: [:project_name, :status, :start_date, :end_date]),
#     total_count: total_count
#   }, status: :ok
# end

   def leave_banks
      @user = User.find(params[:id])
      @leave_banks = @user.leave_banks
      if @leave_banks.empty?
    render json: { message: 'No records found' }, status: :ok
  else
      render json: @leave_banks, status: :ok
   end
 end
  def work_experiences 
      @user = User.find(params[:id])
      @work_experiences = @user.work_experiences
       if @work_experiences.present?
   render json: @work_experiences, status: :ok
  else
      
       render json: { message: 'No records found' }, status: :ok
   end
 end
  #  def work_experiences
  #     @user = User.find(params[:id])
  #     @work_experiences = @user.work_experiences.order(created_at: :desc)
  #                                               .paginate(page: params[:page], per_page: 4)
  #     # render json: @work_experiences, status: :ok
  #  total_count = @work_experiences.total_entries

  # render json: {
  #   work_experiences: @work_experiences,
  #   total_count: total_count
  # }, status: :ok
  #  end

   def skills 
      @user = User.find(params[:id])
      @skills = @user.skills
       if @skills.empty?
    render json: { message: 'No records found' }, status: :ok
  else
      render json: @skills, status: :ok
   end
  end 
  #  def skills
  #     @user = User.find(params[:id])
  #     @skills = @user.skills.order(created_at: :desc)
  #                           .paginate(page: params[:page], per_page: 2)
  #     # render json: @work_experiences, status: :ok
  #  total_count = @skills.total_entries

  # render json: {
  #   skills: @skills,
  #   total_count: total_count
  # }, status: :ok
  #     # render json: @skills, status: :ok
  #  end

   def bank_details
      @user = User.find(params[:id])
      @bank_details = @user.bank_details
      if @bank_details.present?
     render json: @bank_details, status: :ok
   
  else
    render json: { message: 'No records found' }, status: :ok
   end
 end

   def create
     
    @users = User.new(user_params)
    if @users.save
      render json: @users, status: :created
    else
      render json: @users.errors, status: :unprocessable_entity
    end
  end

  def update
    @users = User.find_by_id(params[:id])

    if @users.update(user_params)
      render json: @users
    else
      render json: @users.errors, status: :unprocessable_entity
    end
  end

   def date_of_joining
    user = User.find(params[:id])
    if user
      render json: { date_of_joining: user.date_of_joining }
    else
      render json: { error: 'User not found' }, status: :ok
    end
  end
  
#   def update_allow
#   @user = User.find(params[:id])

#   if @user.update(allow: true)
#     render json: @user, status: :ok
#   else
#     render json: @user.errors, status: :unprocessable_entity
#   end
# end

# def check_allow
#   @user = User.find(params[:id])

#   if @user.allow?
#     render json: { allow: true }, status: :ok
#   else
#     render json: { allow: false }, status: :ok
#   end
# end





# def check_allow
#   @user = User.find(params[:id])
#   if params[:approve] == 'true'
#     @user.update(allow: true)
#     render json: { allow: true }, status: :ok
#   elsif params[:approve] == 'false'
#     @user.update(allow: false)

#     render json: { allow: false }, status: :ok
#   else
#     render json: { error: "Invalid value for 'approve' parameter" }, status: :unprocessable_entity
#   end
# end



 

  

 
    
  
  private

   def user_params
    params.permit( :email, :designation, :password, :password_confirmation,
      :employee_id_number, :username, :name, :date_of_joining, roles: [])
   end  

end 




   
