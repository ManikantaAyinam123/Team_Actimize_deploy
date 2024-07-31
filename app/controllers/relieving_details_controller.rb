class RelievingDetailsController < ApplicationController
  before_action :authorize_request

  def index
    @relieving_details = RelievingDetail.order(created_at: :desc).paginate(page: params[:page], per_page: 5)
    # render json: @relieving_details before pagiantion apr 24

    total_count = @relieving_details.count
    per_page = 5
  ratio = (total_count.to_f / per_page).ceil
    if @relieving_details.empty?
    render json: { message: 'No records found' }, status: :ok
  else

    render json: {
      relieving_details: @relieving_details,
      total_pages: ratio
    }, status: :ok
    end
  end

	def create
   
     params.merge!(user_id: @current_user.id) if params.present?
    
    
    @relieving_details = RelievingDetail.new(relieving_details_params)
  
    if @relieving_details.save
      render json: @relieving_details, status: :created
    else
      render json: @relieving_details.errors, status: :unprocessable_entity
    end
  end
  def update
    
    @relieving_details = RelievingDetail.find_by_id(params[:id])

    if @relieving_details.update(relieving_details_params)
      render json: @relieving_details
    else
      render json: @relieving_details.errors, status: :unprocessable_entity
    end
  end




  def destroy
      @relieving_details = RelievingDetail.find_by_id(params[:id])
   if @relieving_details.destroy
      render json: @relieving_details, status: :created
    else
      render json: { errors: "Record not found or deleted.." },
             status: :unprocessable_entity
   end     
    end

  private

  def relieving_details_params
    params.permit(:start_date, :end_date, :exit_type, :expert_id, :user_id)
  end

end
