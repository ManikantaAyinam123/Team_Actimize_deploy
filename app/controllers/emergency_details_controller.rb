class EmergencyDetailsController < ApplicationController
  before_action :authorize_request
  before_action :set_emergency_contact, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource 	

  # def index
  #   @details = EmergencyDetail.where(user_id: @current_user.id).order("created_at ASC")
  #   render json: @details, status: :ok
  # end

  def index
    @details = EmergencyDetail.where(user_id: @current_user.id).order("created_at ASC")
  if @details.empty?
    render json: { message: 'No records found' }, status: :ok
  else

    render json: @details, status: :ok
  end
end

  # GET /emergency_details/id
  def show
    render json: @details, status: :ok
  end

  # POST /emergency_details
  def create
    params.merge!(user_id: @current_user.id,type: "EmergencyDetail") if params.present?
    @detail = EmergencyDetail.new(contact_details_params)
    if @detail.save
      render json: @detail, status: :created
    else
      render json: { errors: @detail.errors.full_messages },
             status: :unprocessable_entity
    end
  end

 
  # PUT /emergency_details/id
  def update
    if @detail.update(contact_details_params)
      render json: @detail, status: :created
    else
      render json: { errors: @detail.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # DELETE /emergency_details/id
  def destroy
   if @detail.destroy
      render json: @detail, status: :created
    else
      render json: { errors: "Record not found or deleted.." },
             status: :unprocessable_entity
   end    
  end

  private

   def set_emergency_contact
    
     @detail = EmergencyDetail.find_by_id(params[:id])
     if @detail.nil?
         render json: { errors: 'Does not exist' },
               status: :unprocessable_entity      
      elsif @detail.user_id == @current_user.id
        @detail
      else 
        @detail = nil
         render json: { errors: 'Something went wrong...' },
               status: :unprocessable_entity          
      end  
   end

  def contact_details_params
    params.permit(:address,:mobile_number,:name,:relationship,:user_id,:email,:type)
  end

end

