class PersonalDetailsController < ApplicationController
  before_action :authorize_request, except: :welcome
  load_and_authorize_resource	
		def welcome
       render plain: "Welcome to Team Actimize..."
		end	

	

		def index
		 @personal_detail = @current_user.personal_detail

		  if @personal_detail.present?
		  	render json: @personal_detail, status: :ok
    
      else
      	 render json: { message: 'No record found' }, status: :ok
      end

		end

	def show
    render json: @personal_detail, status: :ok
  end

	  def create
	  	 
	       @personal_detail = PersonalDetail.find_by_user_id(@current_user.id)
	    
	      params.merge!(user_id: @current_user.id) if params.present?
	    if !@personal_detail.present?
	       @personal_detail = PersonalDetail.new
	    end	
	    if @personal_detail.update(personal_detail_params)

	    	ActivityTracker.create(
      headings: 'Personal Details Update',
      contents: "#{@current_user.name} has updated Personal details.",
      user_id: @personal_detail.user_id,
      action_needed: true,
      notification_type: 'Personal Details Update',
      notification_type_id: @personal_detail.id,
      guest_id: @personal_detail.user_id
    )
	      render json: @personal_detail, status: :created
	    else
	      render json: { errors: @personal_detail.errors.full_messages },
	             status: :unprocessable_entity
	    end
	  end

	
	
	

	  # def profile_pic
	  
	  #   @personal_detail = @current_user.personal_detail
	  
	  # if @personal_detail.present?
  	#  	 @personal_detail.profile_pic = params[:profile_pic]
	 
		#   	if @personal_detail.save
		#       render json: @personal_detail, status: :created
		#     else
		#       render json: { errors: @personal_detail.errors.full_messages },
		#              status: :unprocessable_entity
		#     end
	  #  else 
	  #  	render json: { errors: "Please add personal details first"}
	  #  end
	  # end
	  


	  private


	  def personal_detail_params
	    params.permit(:first_name, :last_name, :date_of_birth, :gender, :nationality,:marital_status,:mobile_number,:company_email,:personal_email,:present_address,:permanent_address,:user_id,:aadhar_card_number,:pan_card_number, :profile_pic, :bio)
	  end

end
