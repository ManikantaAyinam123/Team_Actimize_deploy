class WorkExperiencesController < ApplicationController

  before_action :authorize_request
  before_action :set_experience, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource 
	
def index
  @work_experiences = WorkExperience.where(user_id: @current_user.id)
                                    # .paginate(page: params[:page], per_page: 5)
  total_count = @work_experiences.count

  if @work_experiences.any?
    render json: {
      work_experiences: ActiveModel::Serializer::CollectionSerializer.new(
                          @work_experiences,
                          each_serializer: WorkExperienceSerializer
                        ),
      total_count: total_count
    }, status: :ok
  else
    render json: { message: 'No records found' }, status: :ok
  end
end

#   def index
#   @work_experiences = WorkExperience.where(user_id: @current_user.id)
#                                     .paginate(page: params[:page], per_page: 5)
#   # total_count = @work_experiences.total_entries

#   render json: {
#     work_experiences: ActiveModel::Serializer::CollectionSerializer.new(
#                         @work_experiences,
#                         each_serializer: WorkExperienceSerializer
#                       ),
#     # total_count: total_count
#   }, status: :ok
# end

  # GET /work_experiences/id
  def show
    render json: @work_experience, status: :ok
  end

  

  # POST /work_experiences
  def create
    params.merge!(user_id: @current_user.id) if params.present?
    @work_experience = WorkExperience.new(experience_params)
    if @work_experience.save
      # binding.pry
      # render json: @work_experience, status: :created
      render json: @work_experience, serializer: WorkExperienceSerializer, status: :created
    else
      render json: { errors: @work_experience.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /work_experiences/id
  def update
    if @work_experience.update(experience_params)
      ActivityTracker.create(
      headings: 'WorkExperience Update',
      contents: "#{@current_user.name} has updated WorkExperience details.",
      user_id: @work_experience.user_id,
      action_needed: true,
      notification_type: 'WorkExperience Details Update',
      notification_type_id: @work_experience.id,
      guest_id: @work_experience.user_id
    )

      # render json: @work_experience, status: :created
      render json: @work_experience, serializer: WorkExperienceSerializer, status: :ok
    else
      render json: { errors: @work_experience.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # DELETE /work_experiences/id
  def destroy
   if @work_experience.destroy
      render json: @work_experience, status: :created
    else
      render json: { errors: "Record not found or deleted.." },
             status: :unprocessable_entity
   end    
  end

  private

   def set_experience
      @work_experience = WorkExperience.find_by_id(params[:id])
      if @work_experience.nil?
         render json: { errors: 'Does not exist' },
               status: :unprocessable_entity      
      elsif @work_experience.user_id == @current_user.id
        @work_experience
      else 
        @work_experience = nil
         render json: { errors: 'Something went wrong...' },
               status: :unprocessable_entity          
      end  
   end

  def experience_params
    params.permit(:organization_name,:designation,:date_of_join,:date_of_end,:user_id)
  end

end

