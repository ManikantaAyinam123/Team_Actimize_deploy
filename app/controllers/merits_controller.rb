class MeritsController < ApplicationController

	before_action :authorize_request

  
  def index
    @merits = Merit.order(created_at: :desc).paginate(page: params[:page], per_page: 5)
    # render json: @merits  before pagiantion apr 24
    total_count = @merits.count
    per_page = 5
  ratio = (total_count.to_f / per_page).ceil
    if @merits.empty?
    render json: { message: 'No records found' }, status: :ok
  else

      render json: {
        merits_and_demerits: @merits,
         total_pages: ratio
      }, status: :ok
      end
  end  

  

  def create
    params.merge!(user_id: @current_user.id) if params.present?
    @merit = Merit.new(merits_params)

    if @merit.save
      render json: @merit, status: :created
    else
      render json: @merit.errors, status: :unprocessable_entity
    end
  end

  def update
    @merit = Merit.find(params[:id])

    if @merit.update(merits_params)
      render json: @merit
    else
      render json: @merit.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @merit = Merit.find_by_id(params[:id])
   if @merit.destroy
      render json: @merit, status: :created
    else
      render json: { errors: "Record not found or deleted.." },
             status: :unprocessable_entity
   end    
  end

  private

  def merits_params
    params.permit(:merit_type, :reason, :seviority, :user_id, :expert_id ,:company_email_id)
  end

end
