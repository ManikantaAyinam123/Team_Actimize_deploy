# class ProjectsController < ApplicationController

#   before_action :authorize_request
  
#   before_action :set_project, only: [:show, :edit, :update, :destroy]
#    # load_and_authorize_resource	

# #  def index
# #   # binding.pry
   
# #   # all projects for ht
# #   @projects = Project.order(created_at: :desc)

# #   if params[:page].present?
# #     @projects = @projects.paginate(page: params[:page], per_page: 6)
# #   else
# #     @projects = @projects.first(6)
# #   end

# #   @projects_with_members = @projects.map do |project|
# #     project_with_members = project.as_json(except: [:user_id]).merge(
# #       assigned_by: project.user.username,
# #       members: project.assigned_users.map do |user|
# #         user.as_json(only: [:id, :email, :name, :username, :designation, :employee_id_number, :date_of_joining, :active])
# #       end
# #     )
# #     project_with_members
# #   end

# #   render json: @projects_with_members, status: :ok
# # end 

#   def index
#     # binding.pry
#     # this api is for hr
#       @project = Project.order(created_at: :desc)
      
#         @projects = @project.paginate(page: params[:page], per_page: 5)
     

#       @projects_with_members = @projects.map do |project|
#         project.as_json(except: [:user_id]).merge(
#           members: project.assigned_users.count,
#           assigned_by: project.user.username,
          
#            members_list: project.assigned_users.map do |user|
#         user.as_json(only: [:id, :email, :name, :designation, :employee_id_number, :date_of_joining, :active])
#       end
#         )
#       end
#        total_count = @projects.count
#        per_page = 5
#   ratio = (total_count.to_f / per_page).ceil

#   if @projects_with_members.empty?
#     render json: { message: 'No records found' }, status: :ok
#   else

#     render json: {
#       projects: @projects_with_members,
#        total_pages: ratio
#     }, status: :ok

#         # render json: @projects_with_members, status: :ok
#     end

#   end



#   # def index  before 24 apr pagination
    
#   #     @projects = Project.order(created_at: :desc)
#   #     if params[:page].present?
#   #       @projects = @projects.paginate(page: params[:page], per_page: 3)
#   #     else
#   #       @projects = @projects.first(3)
#   #     end

#   #     @projects_with_members = @projects.map do |project|
#   #       project.as_json(except: [:user_id]).merge(
#   #         members: project.assigned_users.count,
#   #         assigned_by: project.user.username,
#   #         # binding.pry
#   #          members_list: project.assigned_users.map do |user|
#   #       user.as_json(only: [:id, :email, :name, :username, :designation, :employee_id_number, :date_of_joining, :active])
#   #     end
#   #       )
#   #     end

#   #     # render json: @projects_with_members, status: :ok before pagination apr 24

#   #     total_count = @projects.count
#   #      per_page = 3
#   # ratio = (total_count.to_f / per_page).ceil

#   # render json: {
#   #   projects: @projects_with_members,
#   #    total_pages: ratio
#   # }, status: :ok
#   # end

# # def projects  commented for user name

# #     # projects for emp owned and assigned
# #   # Projects where the current user is the owner
# #   @projects_owned_by_user = @current_user.projects.order(created_at: :desc)

# #     if params[:page].present?
# #       @projects_owned_by_user = @projects_owned_by_user.paginate(page: params[:page], per_page: 6)
# #     else
# #       @projects_owned_by_user = @projects_owned_by_user.first(5)
# #     end

# #   # Projects where the current user is a member
# #   @projects_part_of = Project.joins(:assigned_users).where(users: { id: @current_user.id }).order(created_at: :desc)

# #     if params[:page].present?
# #       @projects_part_of = @projects_part_of.paginate(page: params[:page], per_page: 5)
# #     else
# #       @projects_part_of = @projects_part_of.first(5)
# #     end

# #   @total_projects_for_user = @current_user.projects.count + @projects_part_of.count

# #   @projects_owned_with_members = @projects_owned_by_user.map do |project|
# #     project.as_json(except: [:user_id]).merge(
# #       members: project.assigned_users.count,
# #       assigned_by: project.user.username
# #     )
# #   end

# #   @projects_part_of_with_members = @projects_part_of.map do |project|
# #     project.as_json(except: [:user_id]).merge(
# #       members: project.assigned_users.count,
# #       assigned_by: project.user.username
# #     )
# #   end

# #   all_projects = @projects_owned_with_members + @projects_part_of_with_members

# #   total_count = all_projects.count
# #        per_page = 5
# #   ratio = (total_count.to_f / per_page).ceil
  
# #    if all_projects.empty?
# #     render json: { message: 'No records found' }, status: :ok
# #   else

# #       render json: {
# #         projects: all_projects,
# #          # total_pages: ratio
# #           per_page: 6,
# #           total_projects: total_count
# #       }, status: :ok
      

# #       # render json: all_projects, status: :ok  before pagination apr 24
# #     end
# #   end

# def projects
#   # Projects where the current user is the owner
#   @projects_owned_by_user = @current_user.projects.order(created_at: :desc)

#   # Projects where the current user is a member
#   @projects_part_of = Project.joins(:assigned_users).where(users: { id: @current_user.id }).order(created_at: :desc)

#   @total_projects_for_user = @current_user.projects.count + @projects_part_of.count

#   @projects_owned_with_members = @projects_owned_by_user.map do |project|
#     project.as_json(except: [:user_id]).merge(
#       members: project.assigned_users.map { |user| user.as_json(only: [:id, :name, :designation]) },
#       assigned_by: project.user.username
#     )
#   end

#   @projects_part_of_with_members = @projects_part_of.map do |project|
#     project.as_json(except: [:user_id]).merge(
#       members: project.assigned_users.map { |user| user.as_json(only: [:id, :name, :designation]) },
#       assigned_by: project.user.username
#     )
#   end

#   all_projects = @projects_owned_with_members + @projects_part_of_with_members

#   # Paginate all_projects with four projects per page
#   all_projects = all_projects.paginate(page: params[:page], per_page: 3)

#   total_count = all_projects.total_entries

#   if all_projects.empty?
#     render json: { message: 'No records found' }, status: :ok
#   else
#     render json: {
#       projects: all_projects,
#       per_page: 3,
#       total_projects: total_count
#     }, status: :ok
#   end
# end
  


  

  

#   # GET /projects/id
#   def show
#     render json: @projects.to_json, status: :ok
#   end

 
#   # POST /projects
#   # def create
#   #   params.merge!(user_id: @current_user.id) if params.present?
#   #   @project = Project.new(project_params)
#   #   if @project.save
#   #     @members = params[:members] if params[:members].present?
#   #     @members = User.where(id: @members).pluck(:id)
#   #     if @members
#   #       assign_user
#   #     end  
#   #     render json: @project, status: :ok
#   #   else
#   #     render json: { errors: @project.errors.full_messages },
#   #            status: :unprocessable_entity
#   #   end
#   # end

#   def create
#   params.merge!(user_id: @current_user.id) if params.present?
#   @project = Project.new(project_params)

#   if @project.save
#     @members = params[:members] if params[:members].present?
#     @members = User.where(id: @members).pluck(:id)

#     if @members
#       assign_user

#     assigned_user_names = User.where(id: @members).pluck(:username).join(', ')

#       # Create notification for each member
#       @members.each do |member_id|
#         Notification.create(
#           headings: 'New Project',
#           # contents: "#{@current_user.name} has created a new project: #{@project.name}",
#           contents: "#{@current_user.name} has created a new project.You are assigned to that project, project name is #{@project.project_name}, and the team members are #{assigned_user_names} and Project start date is #{@project.start_date}, Project end date is #{@project.end_date}",
#           user_id: member_id,
#           action_needed: true,
#           notification_type: 'New Project',
#           notification_type_id: @project.id,
#           guest_id: @current_user.id
#         )
#       end
#     end

#     render json: @project, status: :ok
#   else
#     render json: { errors: @project.errors.full_messages },
#            status: :unprocessable_entity
#   end
# end

#   # PUT /projects/id
#   # def update
#   #   if @project.update(project_params)
#   #     # binding.pry
#   #     @project.assigned_users.delete_all if @project.assigned_users.present?
#   #     @members = params[:members] if params[:members].present?
#   #     @members = User.where(id: @members).pluck(:id)
#   #     if @members
#   #       assign_user

#   #        assigned_user_names = User.where(id: @members).pluck(:name).join(', ')

#   #     # Create notification for each member
#   #     @members.each do |member_id|
#   #       Notification.create(
#   #         headings: 'New Project',
#   #         # contents: "#{@current_user.name} has created a new project: #{@project.name}",
#   #         contents: "#{@current_user.name} has created a new project.You are assigned to that project, project name is #{@project.project_name}, and the team members are #{assigned_user_names} and Project start date is #{@project.start_date}, Project end date is #{@project.end_date}",
#   #         user_id: member_id,
#   #         action_needed: true,
#   #         notification_type: 'New Project',
#   #         notification_type_id: @project.id,
#   #         guest_id: @current_user.id
#   #       )
#   #     end
#   #     end       
#   #     render json: @project, status: :ok
#   #   else
#   #     render json: { errors: @project.errors.full_messages },
#   #            status: :unprocessable_entity
#   #   end
#   # end

#   def update
#   if @project.update(project_params)
#     # Only delete assigned users if params[:members] is present
#     if params[:members].present?
#       @project.assigned_users.delete_all if @project.assigned_users.present?

#       @members = User.where(id: params[:members]).pluck(:id)
#       assign_user

#       # assigned_user_names = User.where(id: @members).pluck(:name).join(', ')

#       # # Create notification for each member
#       # @members.each do |member_id|
#       #   Notification.create(
#       #     headings: 'New Project',
#       #     contents: "#{@current_user.name} has created a new project. You are assigned to that project, project name is #{@project.project_name}, and the team members are #{assigned_user_names} and Project start date is #{@project.start_date}, Project end date is #{@project.end_date}",
#       #     user_id: member_id,
#       #     action_needed: true,
#       #     notification_type: 'New Project',
#       #     notification_type_id: @project.id,
#       #     guest_id: @current_user.id
#       #   )
#       # end
#     end

#     render json: @project, status: :ok
#   else
#     render json: { errors: @project.errors.full_messages },
#            status: :unprocessable_entity
#   end
# end



#   # DELETE /projects/id
#   def destroy
#    if @project.destroy
#       @project.assigned_users.delete_all if @project.assigned_users.present?
#       render json: @project, status: :ok
#     else
#       render json: { errors: "Record not found or deleted.." },
#              status: :unprocessable_entity
#    end    
#   end

#   def assign_user
#     @members.each do |user|
#       @user_project = UserProject.new(user_id: user,project_id: @project.id)
#       if @user_project.save
#           puts "user saved"
#       else
#         render json: { errors: @user_project.errors.full_messages },
#            status: :unprocessable_entity          
#       end 
#     end    
#   end  

#   private

#    def set_project
#       @project = Project.find_by_id(params[:id])
#       if @project.nil?
#          render json: { errors: 'Does not exist' },
#                status: :unprocessable_entity      
#       elsif @project
#         @project
#       else 

#         @project = nil
#          render json: { errors: 'Something went wrong...' },
#                status: :unprocessable_entity          
#       end  
#    end

#   def project_params
#     params.permit(:project_name, :status, :start_date,:end_date,:user_id, :description, :assigned_users => [])
#   end


# end






















class ProjectsController < ApplicationController

  before_action :authorize_request
  
  before_action :set_project, only: [:show, :edit, :update, :destroy]
   # load_and_authorize_resource  

#  def index
#   # binding.pry
   
#   # all projects for ht
#   @projects = Project.order(created_at: :desc)

#   if params[:page].present?
#     @projects = @projects.paginate(page: params[:page], per_page: 6)
#   else
#     @projects = @projects.first(6)
#   end

#   @projects_with_members = @projects.map do |project|
#     project_with_members = project.as_json(except: [:user_id]).merge(
#       assigned_by: project.user.username,
#       members: project.assigned_users.map do |user|
#         user.as_json(only: [:id, :email, :name, :username, :designation, :employee_id_number, :date_of_joining, :active])
#       end
#     )
#     project_with_members
#   end

#   render json: @projects_with_members, status: :ok
# end 

  def index
    # binding.pry
    # this api is for hr
      @project = Project.order(created_at: :desc)
      
        @projects = @project.paginate(page: params[:page], per_page: 5)
     

      @projects_with_members = @projects.map do |project|
        project.as_json(except: [:user_id]).merge(
          members: project.assigned_users.count,
          assigned_by: project.user.username,
          
           members_list: project.assigned_users.map do |user|
        user.as_json(only: [:id, :email, :name, :designation, :employee_id_number, :date_of_joining, :active])
      end
        )
      end
       total_count = @projects.count
       per_page = 5
  ratio = (total_count.to_f / per_page).ceil

  if @projects_with_members.empty?
    render json: { message: 'No records found' }, status: :ok
  else

    render json: {
      projects: @projects_with_members,
       total_pages: ratio
    }, status: :ok

        # render json: @projects_with_members, status: :ok
    end

  end



  # def index  before 24 apr pagination
    
  #     @projects = Project.order(created_at: :desc)
  #     if params[:page].present?
  #       @projects = @projects.paginate(page: params[:page], per_page: 3)
  #     else
  #       @projects = @projects.first(3)
  #     end

  #     @projects_with_members = @projects.map do |project|
  #       project.as_json(except: [:user_id]).merge(
  #         members: project.assigned_users.count,
  #         assigned_by: project.user.username,
  #         # binding.pry
  #          members_list: project.assigned_users.map do |user|
  #       user.as_json(only: [:id, :email, :name, :username, :designation, :employee_id_number, :date_of_joining, :active])
  #     end
  #       )
  #     end

  #     # render json: @projects_with_members, status: :ok before pagination apr 24

  #     total_count = @projects.count
  #      per_page = 3
  # ratio = (total_count.to_f / per_page).ceil

  # render json: {
  #   projects: @projects_with_members,
  #    total_pages: ratio
  # }, status: :ok
  # end

# def projects  commented for user name

#     # projects for emp owned and assigned
#   # Projects where the current user is the owner
#   @projects_owned_by_user = @current_user.projects.order(created_at: :desc)

#     if params[:page].present?
#       @projects_owned_by_user = @projects_owned_by_user.paginate(page: params[:page], per_page: 6)
#     else
#       @projects_owned_by_user = @projects_owned_by_user.first(5)
#     end

#   # Projects where the current user is a member
#   @projects_part_of = Project.joins(:assigned_users).where(users: { id: @current_user.id }).order(created_at: :desc)

#     if params[:page].present?
#       @projects_part_of = @projects_part_of.paginate(page: params[:page], per_page: 5)
#     else
#       @projects_part_of = @projects_part_of.first(5)
#     end

#   @total_projects_for_user = @current_user.projects.count + @projects_part_of.count

#   @projects_owned_with_members = @projects_owned_by_user.map do |project|
#     project.as_json(except: [:user_id]).merge(
#       members: project.assigned_users.count,
#       assigned_by: project.user.username
#     )
#   end

#   @projects_part_of_with_members = @projects_part_of.map do |project|
#     project.as_json(except: [:user_id]).merge(
#       members: project.assigned_users.count,
#       assigned_by: project.user.username
#     )
#   end

#   all_projects = @projects_owned_with_members + @projects_part_of_with_members

#   total_count = all_projects.count
#        per_page = 5
#   ratio = (total_count.to_f / per_page).ceil
  
#    if all_projects.empty?
#     render json: { message: 'No records found' }, status: :ok
#   else

#       render json: {
#         projects: all_projects,
#          # total_pages: ratio
#           per_page: 6,
#           total_projects: total_count
#       }, status: :ok
      

#       # render json: all_projects, status: :ok  before pagination apr 24
#     end
#   end

def projects
  # Projects where the current user is the owner
  @projects_owned_by_user = @current_user.projects.order(created_at: :desc)

  # Projects where the current user is a member
  @projects_part_of = Project.joins(:assigned_users).where(users: { id: @current_user.id }).order(created_at: :desc)

  @total_projects_for_user = @current_user.projects.count + @projects_part_of.count

  @projects_owned_with_members = @projects_owned_by_user.map do |project|
    project.as_json(except: [:user_id]).merge(
      members: project.assigned_users.map { |user| user.as_json(only: [:id, :name, :designation]) },
    
    )
  end

  @projects_part_of_with_members = @projects_part_of.map do |project|
    project.as_json(except: [:user_id]).merge(
      members: project.assigned_users.map { |user| user.as_json(only: [:id, :name, :designation]) },
     
    )
  end

  all_projects = @projects_owned_with_members + @projects_part_of_with_members

  # Paginate all_projects with four projects per page
  all_projects = all_projects.paginate(page: params[:page], per_page: 3)

  total_count = all_projects.total_entries

  if all_projects.empty?
    render json: { message: 'No records found' }, status: :ok
  else
    render json: {
      projects: all_projects,
      per_page: 3,
      total_projects: total_count
    }, status: :ok
  end
end
  


  

  

  # GET /projects/id
  def show
    render json: @projects.to_json, status: :ok
  end

 
  # POST /projects
  # def create
  #   params.merge!(user_id: @current_user.id) if params.present?
  #   @project = Project.new(project_params)
  #   if @project.save
  #     @members = params[:members] if params[:members].present?
  #     @members = User.where(id: @members).pluck(:id)
  #     if @members
  #       assign_user
  #     end  
  #     render json: @project, status: :ok
  #   else
  #     render json: { errors: @project.errors.full_messages },
  #            status: :unprocessable_entity
  #   end
  # end

  def create
  params.merge!(user_id: @current_user.id) if params.present?
  @project = Project.new(project_params)

  if @project.save
    @members = params[:members] if params[:members].present?
    @members = User.where(id: @members).pluck(:id)

    if @members
      assign_user

    assigned_user_names = User.where(id: @members).pluck(:username).join(', ')

      # Create notification for each member
      @members.each do |member_id|
        Notification.create(
          headings: 'New Project',
          # contents: "#{@current_user.name} has created a new project: #{@project.name}",
          contents: "#{@current_user.name} has created a new project.You are assigned to that project, project name is #{@project.project_name}, and the team members are #{assigned_user_names} and Project start date is #{@project.start_date}, Project end date is #{@project.end_date}",
          user_id: member_id,
          action_needed: true,
          notification_type: 'New Project',
          notification_type_id: @project.id,
          guest_id: @current_user.id
        )
      end
    end

    render json: @project, status: :ok
  else
    render json: { errors: @project.errors.full_messages },
           status: :unprocessable_entity
  end
end

  # PUT /projects/id
  # def update
  #   if @project.update(project_params)
  #     # binding.pry
  #     @project.assigned_users.delete_all if @project.assigned_users.present?
  #     @members = params[:members] if params[:members].present?
  #     @members = User.where(id: @members).pluck(:id)
  #     if @members
  #       assign_user

  #        assigned_user_names = User.where(id: @members).pluck(:name).join(', ')

  #     # Create notification for each member
  #     @members.each do |member_id|
  #       Notification.create(
  #         headings: 'New Project',
  #         # contents: "#{@current_user.name} has created a new project: #{@project.name}",
  #         contents: "#{@current_user.name} has created a new project.You are assigned to that project, project name is #{@project.project_name}, and the team members are #{assigned_user_names} and Project start date is #{@project.start_date}, Project end date is #{@project.end_date}",
  #         user_id: member_id,
  #         action_needed: true,
  #         notification_type: 'New Project',
  #         notification_type_id: @project.id,
  #         guest_id: @current_user.id
  #       )
  #     end
  #     end       
  #     render json: @project, status: :ok
  #   else
  #     render json: { errors: @project.errors.full_messages },
  #            status: :unprocessable_entity
  #   end
  # end

  def update
  if @project.update(project_params)
    # Only delete assigned users if params[:members] is present
    if params[:members].present?
      @project.assigned_users.delete_all if @project.assigned_users.present?

      @members = User.where(id: params[:members]).pluck(:id)
      assign_user

      # assigned_user_names = User.where(id: @members).pluck(:name).join(', ')

      # # Create notification for each member
      # @members.each do |member_id|
      #   Notification.create(
      #     headings: 'New Project',
      #     contents: "#{@current_user.name} has created a new project. You are assigned to that project, project name is #{@project.project_name}, and the team members are #{assigned_user_names} and Project start date is #{@project.start_date}, Project end date is #{@project.end_date}",
      #     user_id: member_id,
      #     action_needed: true,
      #     notification_type: 'New Project',
      #     notification_type_id: @project.id,
      #     guest_id: @current_user.id
      #   )
      # end
    end

    render json: @project, status: :ok
  else
    render json: { errors: @project.errors.full_messages },
           status: :unprocessable_entity
  end
end



  # DELETE /projects/id
  def destroy
   if @project.destroy
      @project.assigned_users.delete_all if @project.assigned_users.present?
      render json: @project, status: :ok
    else
      render json: { errors: "Record not found or deleted.." },
             status: :unprocessable_entity
   end    
  end

  def assign_user
    @members.each do |user|
      @user_project = UserProject.new(user_id: user,project_id: @project.id)
      if @user_project.save
          puts "user saved"
      else
        render json: { errors: @user_project.errors.full_messages },
           status: :unprocessable_entity          
      end 
    end    
  end  

  private

   def set_project
      @project = Project.find_by_id(params[:id])
      if @project.nil?
         render json: { errors: 'Does not exist' },
               status: :unprocessable_entity      
      elsif @project
        @project
      else 

        @project = nil
         render json: { errors: 'Something went wrong...' },
               status: :unprocessable_entity          
      end  
   end

  def project_params
    params.permit(:project_name, :status, :start_date,:end_date,:user_id, :description, :assigned_users => [])
  end


end

