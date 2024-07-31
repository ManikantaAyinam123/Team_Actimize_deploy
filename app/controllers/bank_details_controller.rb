class BankDetailsController < ApplicationController
  before_action :authorize_request
  # load_and_authorize_resource 


  def index
    
    
   @bank_detail = @current_user.bank_detail
   if @bank_detail.present?
     render json: @bank_detail, status: :ok
   else
     render json: { message: 'No records found' }, status: :ok
     
   end
    end
 	


     
  def show
     @bank_detail = BankDetail.find_by_id(params[:id])
      render json: @bank_detail, status: :ok
  end



  # def create  commented for front end dev convency
   
  #     @bank_detail = BankDetail.find_by_user_id(@current_user.id)

  #     # params.merge!(user_id: @current_user.id) if params.present?
  #   if !@bank_detail.present?
  #      @bank_detail = BankDetail.new
  #   end 
  #   if @bank_detail.update(bank_detail_params)
  #      render json: @bank_detail, status: :ok
  #   else
  #     render json: { errors: @bank_detail.errors.full_messages },
  #            status: :unprocessable_entity
  #   end
  # end

  
   def create
  user_id = params[:id] 
  @bank_detail = BankDetail.find_by(user_id: user_id) 

  if !@bank_detail.present?
       @bank_detail = BankDetail.new
    end 

  if @bank_detail.update(bank_detail_params.merge(user_id: user_id)) # Merge user_id into the params
    render json: @bank_detail, status: :ok
  else
    render json: { errors: @bank_detail.errors.full_messages }, status: :unprocessable_entity
  end
end




  private


  def bank_detail_params
    params.permit(:bank_name, :account_number,:user_id,:ifsc_code,:branch_name)
  end	


  
end
