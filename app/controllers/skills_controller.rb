  class SkillsController < ApplicationController

      before_action :authorize_request
      before_action :set_skill, only: [:show, :edit, :update, :destroy]
      load_and_authorize_resource 	


        def all_users_with_skills
         
          all_skills = Skill.distinct.pluck(:skill_name)
          
           render json: { skills: all_skills }, status: :ok
        
        end


   def search_users_related_to_skill
    
        skill_name = params[:skill_name]
        users = User.joins(:skills)
                    .joins(:personal_detail)
                    .where('skills.skill_name LIKE ?', "%#{skill_name}%")
                    .active
                    .select('users.name, users.designation, users.employee_id_number, users.email, personal_details.mobile_number')
                     .paginate(page: params[:page], per_page: 5)
        # if users.present?
          # render json: users, status: :ok    before pagination apr 24
        total_count = users.count
   per_page = 5
  ratio = (total_count.to_f / per_page).ceil
 if users.present?
  render json: {
    skilled_users: users,
    total_pages: ratio
  }, status: :ok
   
  else
     render json: { message: 'No records found' }, status: :ok
        # else 
        #   render json: { message: "No results found" }, status: :ok
         end
    end


# def search_users_by_skill
#   skill_name = params[:skill_name]
#   users = User.joins(:skills)
#               .joins(:personal_detail)
#               .where('skills.skill_name LIKE ?', "%#{skill_name}%")
#               .active
#               .select('users.name, users.designation, users.employee_id_number, users.email, personal_details.mobile_number')

#   paginated_users = paginate_users(users)

#   if paginated_users.present?
#     render json: paginated_users, status: :ok
#   else 
#     render json: { message: "No results found" }, status: :ok
#   end
# end

def paginate_users_list
  # users = User.all
    users = User.joins(:skills)
                .joins(:personal_detail)
                .active
                .select('users.name, users.designation, users.employee_id_number, users.email, personal_details.mobile_number')
            

  paginated_users = paginate_users(users)

  if paginated_users.present?
    render json: paginated_users, status: :ok
  else 
    render json: { message: "No results found" }, status: :ok
  end
end



    # def index  before pagination apr 24
    #   @skills = Skill.where(user_id: @current_user.id).all.order("created_at DESC")
    #   if params[:page].present?
    #    @skills =   @skills.paginate(page: params[:page], per_page: 5)
    #   else 
    #    @skills =   @skills.first(5)
    #   end	
    #   render json: @skills, status: :ok
    # end

def index
  @skills = Skill.where(user_id: @current_user.id)
                 .order(created_at: :desc)
                 .paginate(page: params[:page], per_page: 5)
  total_count = @skills.count
  per_page = 5
  ratio = (total_count.to_f / per_page).ceil
 
  if @skills.empty?
    render json: { message: 'No records found' }, status: :ok
  else

    render json: {
      skills: @skills,
      # total_count: total_count,
      total_pages: ratio
    }, status: :ok
    end
  end

    # GET /skills/id
    def show
    
      render json: @skill, status: :ok
    end

 
 

  # POST /skills
    def create
      params.merge!(user_id: @current_user.id) if params.present?
      @skill = Skill.new(skill_params)
      if @skill.save
        render json: @skill, status: :created
      else
        render json: { errors: @skill.errors.full_messages },
               status: :unprocessable_entity
      end
    end

  # PUT /skills/id
    def update
      if @skill.update(skill_params)
        ActivityTracker.create(
      headings: 'Skill Details Update',
      contents: "#{@current_user.name} has updated Skill details.",
      user_id: @skill.user_id,
      action_needed: true,
      notification_type: 'Skill Details Update',
      notification_type_id: @skill.id,
      guest_id: @skill.user_id
    )
        
        render json: @skill, status: :created
      else
        render json: { errors: @skill.errors.full_messages },
               status: :unprocessable_entity
      end
    end

  # DELETE /skills/id
    def destroy
     if @skill.destroy
        render json: @skill, status: :created
      else
        render json: { errors: "Record not found or deleted.." },
               status: :unprocessable_entity
     end    
    end

def sidebar_profile_card
  if @current_user.present? 
    current_user = @current_user
   
    render json: {
      current_user: {
        id: current_user.id,
        name: current_user.name,
        designation: current_user.designation,
        profile_pic: current_user.personal_detail.profile_pic
      }
    }, status: :ok
  else
    render json: { message: 'No records found' }, status: :ok
  end
end


  private

     def set_skill
        @skill = Skill.find_by_id(params[:id])
        if @skill.nil?
           render json: { errors: 'Does not exist' },
                 status: :unprocessable_entity      
        elsif @skill.user_id == @current_user.id
          @skill
        else 
          @skill = nil
           render json: { errors: 'Something went wrong...' },
                 status: :unprocessable_entity          
        end  
     end

      def skill_params
        params.permit(:skill_name,:rating,:user_id)
      end

      def paginate_users(users)
        users.paginate(page: params[:page], per_page: 5)
      end


end

