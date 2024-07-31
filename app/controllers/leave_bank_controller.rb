class LeaveBankController < ApplicationController
 before_action :authorize_request
 # load_and_authorize_resource  


 def index
      @leave_banks = @current_user.leave_banks.order(created_at: :desc).paginate(page: params[:page], per_page: 5)
      if @leave_banks.empty?
    render json: { message: 'No records found' }, status: :ok
  else

      render json: @leave_banks
  end

  end

    def all_leave_banks
  @leave_banks = LeaveBank.order(created_at: :desc).paginate(page: params[:page], per_page: 5)
  total_count = @leave_banks.count
  per_page = 5
  ratio = (total_count.to_f / per_page).ceil

  # render json: @leave_banks, each_serializer: LeaveBankSerializer, total_pages: ratio, status: :ok
  if @leave_banks.empty?
    render json: { message: 'No records found' }, status: :ok
  else

      # render json: @leave_banks, each_serializer: LeaveBankSerializer, total_pages: ratio, status: :ok
     render json: {
        leave_banks: ActiveModel::Serializer::CollectionSerializer.new(
                            @leave_banks,
                            each_serializer: LeaveBankSerializer
                          ),
         total_pages: ratio
      }, status: :ok

  end
end
	
  def create
    
     params.merge!(user_id: @current_user.id) if params.present?
    @leave_bank = LeaveBank.new(leave_bank_params)

    if @leave_bank.save
      render json: @leave_bank, serializer: LeaveBankSerializer, status: :created
    else
      render json: @leave_bank.errors, status: :unprocessable_entity
    end
  end
  def show
    @leave_bank = LeaveBank.find(params[:id])
     render json: @leave_bank, serializer: LeaveBankSerializer, status: :ok
  end

    def update
     
  	  @leave_bank = LeaveBank.find_by_id(params[:id])

  	  if @leave_bank.update(leave_bank_params)
  	    render json: @leave_bank, status: :ok
  	  else
  	    render json: @leave_bank.errors, status: :unprocessable_entity
  	  end
    end

    def destroy
    @leave_bank = LeaveBank.find_by_id(params[:id])
   if @leave_bank.destroy
      render json: @leave_bank, status: :ok
    else
      render json: { errors: "Record not found or deleted.." },
             status: :unprocessable_entity
   end    
  end

  private

	def leave_bank_params
	    params.permit( :user_id,:year, :casual_leaves, :sick_leaves, :other_leaves, :expert_id)
	end

end
