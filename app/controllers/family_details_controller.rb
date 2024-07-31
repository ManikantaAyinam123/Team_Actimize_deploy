class FamilyDetailsController < ApplicationController
  before_action :authorize_request
  before_action :set_family_contact, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource 	

  def index
    @details = FamilyDetail.where(user_id: @current_user.id).order("created_at ASC")
    if @details.empty?
    render json: { message: 'No records found' }, status: :ok
    else  

      render json: @details, status: :ok
    end
  end 

  # GET /family_details/id
  def show
    render json: @detail, status: :ok
  end

  # POST /family_details
  def create
    params.merge!(user_id: @current_user.id,type: "FamilyDetail") if params.present?
    @detail = FamilyDetail.new(contact_details_params)
    if @detail.save
      render json: @detail, status: :created
    else
      render json: { errors: @detail.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  

  # PUT /family_details/id
  def update
    if @detail.update(contact_details_params)
      # Notification.create(
        ActivityTracker.create(
      headings: 'Family Details Update',
      contents: "#{@current_user.name} has updated Family details.",
      user_id: @detail.user_id,
      action_needed: true,
      notification_type: 'Family Details Update',
      notification_type_id: @detail.id,
      guest_id: @detail.user_id
    )

      render json: @detail, status: :created
    else
      render json: { errors: @detail.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # DELETE /family_details/id
  def destroy
   if @detail.destroy
      render json: @detail, status: :created
    else
      render json: { errors: "Record not found or deleted.." },
             status: :unprocessable_entity
   end    
  end

  private

   def set_family_contact
      @detail = FamilyDetail.find_by_id(params[:id])
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
