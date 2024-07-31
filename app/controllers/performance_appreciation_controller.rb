class PerformanceAppreciationController < ApplicationController
  before_action :authorize_request

  
  def index
      @performance_appreciation = PerformanceAppreciation.order(created_at: :desc).paginate(page: params[:page], per_page: 5)
      # render json: @performance_appreciation  before pagination apr 24

       total_count = @performance_appreciation.count
       per_page = 5
  ratio = (total_count.to_f / per_page).ceil
   if @performance_appreciation.empty?
    render json: { message: 'No records found' }, status: :ok
  else

      render json: {
        performance_appreciation: @performance_appreciation,
         total_pages: ratio
      }, status: :ok
      end
  end  

	def create
    params.merge!(user_id: @current_user.id) if params.present?
    @performance_appreciation = PerformanceAppreciation.new(performance_appreciation_params)

    if @performance_appreciation.save
      render json: @performance_appreciation, status: :created
    else
      render json: @performance_appreciation.errors, status: :unprocessable_entity
    end
  end

  def update
    @performance_appreciation = PerformanceAppreciation.find(params[:id])

    if @performance_appreciation.update(performance_appreciation_params)
      render json: @performance_appreciation
    else
      render json: @performance_appreciation.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @performance_appreciation = PerformanceAppreciation.find_by_id(params[:id])
   if @performance_appreciation.destroy
      render json: @performance_appreciation, status: :created
    else
      render json: { errors: "Record not found or deleted.." },
             status: :unprocessable_entity
   end    
  end

  private

  def performance_appreciation_params
    params.permit(:expert_name, :appreciation_date, :message, :expert_id, :user_id)

  end


end
