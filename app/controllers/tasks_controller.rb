class TasksController < ApplicationController

  before_action :authorize_request
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource 	
  before_action :check_permission, only: [:edit, :update, :destroy]

  # def index  before paginatioan apr 24
  #   @tasks = Task.where(user_id: @current_user.id).all.order("created_at DESC")
  #   if params[:page].present?
  #    @tasks =  @tasks.paginate(page: params[:page], per_page: 5)
  #   else 
  #    @tasks =  @tasks.first(5)
  #   end	
   
  #   render json: @tasks, status: :ok
  # end

   def index
    @tasks = Task.where(user_id: @current_user.id).all.order("created_at DESC")
                 .paginate(page: params[:page], per_page: 5)
   
    # render json: @tasks, status: :ok
    total_count = @tasks.count
    per_page = 5
  ratio = (total_count.to_f / per_page).ceil
  if @tasks.empty?
    render json: { message: 'No records found' }, status: :ok
  else
    render json: {
      tasks: @tasks,
       total_pages: ratio
    }, status: :ok
    end
  end

  # GET /tasks/id
  def show
    render json: @task, status: :ok
  end

  # POST /tasks
  def create
    params.merge!(user_id: @current_user.id) if params.present?
    @task = Task.new(task_params)
    if @task.save
      render json: @task, status: :created
    else
      render json: { errors: @task.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /tasks/id
  def update
    if @task.update(task_params)
      render json: @task, status: :created
    else
      render json: { errors: @task.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # DELETE /tasks/id
  def destroy
   if @task.destroy
      render json: @task, status: :created
    else
      render json: { errors: "Record not found or deleted.." },
             status: :unprocessable_entity
   end    
  end

  private

   def set_task
   
      @task = Task.find_by_id(params[:id])
      if @task.nil?
         render json: { errors: 'Does not exist' },
               status: :unprocessable_entity      
      elsif @task.user_id == @current_user.id
        @task
      else 
        @task = nil
         render json: { errors: 'Something went wrong...' },
               status: :unprocessable_entity          
      end  
   end

   def check_permission
     	expiry = @task.created_at + 24.hours
     	time = Time.now
     
       if time < expiry
         @task
       else
        @task = nil
         render json: { message: 'Something went wrong...' },
               status: :unprocessable_entity           
       end	
   end	

  def task_params
    params.permit(:daily_status,:task_name,:task_progress,:description,:worked_hours,:total_hours,:user_id)
  end

end

