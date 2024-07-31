class GadgetsController < ApplicationController
	before_action :authorize_request

  def index
    
    @gadget = Gadget.order(created_at: :desc).paginate(page: params[:page], per_page: 5)
    # render json: @gadget  before pagination apr 24
     total_count = @gadget.count
     per_page = 5
  ratio = (total_count.to_f / per_page).ceil

  if @gadget.empty?
    render json: { message: 'No records found' }, status: :ok
  else

      render json: {
        gadget: @gadget,
        total_pages: ratio
      }, status: :ok
      end
  end 

  def search_by_name_gad

    if params[:name].present?
      @users = User.where('name LIKE ?', "%#{params[:name]}%").select(:name, :email)
    end
    if @users.present?
      render json: @users.map { |user| user.as_json(except: :id) }
    else 
      render json: {message: "No results found"}  
    end
  end

  def create
    params.merge!(user_id: @current_user.id) if params.present?
    @gadget = Gadget.new(gadget_params)

    if @gadget.save
      render json: @gadget, status: :created
    else
      render json: @gadget.errors, status: :unprocessable_entity
    end
  end

  def update
    @gadget = Gadget.find(params[:id])

    if @gadget.update(gadget_params)
      render json: @gadget
    else
      render json: @gadget.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @gadget = Gadget.find_by_id(params[:id])
   if @gadget.destroy
      render json: @gadget, status: :created
    else
      render json: { errors: "Record not found or deleted.." },
             status: :unprocessable_entity
   end    
  end

  private

  def gadget_params
    params.permit(:date, :employee_id, :designation, :department, :reporting_to, :email_id, :mobile_number, :working_location, :made_by, :serial_number, :model, :color, :charger, :keyboard, :mouse, :bag, :user_id, :expert_id)
  end
end
