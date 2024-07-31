class LeavesController < ApplicationController

  before_action :authorize_request
   # load_and_authorize_resource 	
  before_action :set_leave, only: [ :edit, :update, :destroy]
  before_action :check_permission, only: [ :show, :edit, :update, :destroy]

  # def index before pagination apr 24
  #   @leaves = Leave.where(user_id: @current_user.id).all.order("created_at DESC")
    
  #   if params[:page].present?
      
  #    @leaves =  @leaves.paginate(page: params[:page], per_page: 5)
  #   else 
      
  #    @leaves =  @leaves.first(5)
  #   end	
  #   #
  #   if @current_user.leave_banks.last.present?
  #    render json: {leaves: @leaves, leave_bank: LeaveBankSerializer.new(@current_user.leave_banks.last, serialization_options).serializable_hash},
  #              status: :ok 
  #   else 
  #     render json: {leaves: @leaves, message: "Only leaves"}, status: :ok  
  #   end                            
  # end

    def index 
    @leaves = Leave.where(user_id: @current_user.id).all.order("created_at DESC")
     
     @leaves =  @leaves.paginate(page: params[:page], per_page: 5)
    
    total_count = @leaves.count
     per_page = 5
  ratio = (total_count.to_f / per_page).ceil
   if @leaves.empty?
    render json: { message: 'No records found' }, status: :ok
  else
    
    if @current_user.leave_banks.last.present?
     # render json: {leaves: @leaves, leave_bank: LeaveBankSerializer.new(@current_user.leave_banks.last, serialization_options).serializable_hash},
     #           status: :ok #  before pagination apr 24
    render json: {leaves: @leaves, total_pages: ratio, leave_bank: LeaveBankSerializer.new(@current_user.leave_banks.last, serialization_options).serializable_hash},
               status: :ok 
    else 
      render json: {leaves: @leaves, messages: "Only leaves", total_pages: ratio}, status: :ok  
    end                            
  end
end

  def all_leaves
      
    # @all_leaves = Leave.all.order("created_at DESC")
    # manager_ids = @all_leaves.pluck(:manager_id).uniq
    @all_leaves = Leave.where(manager_id: @current_user).order("created_at DESC")
# manager_ids = @all_leaves.pluck(:manager_id).uniq

   
    # if params[:page].present?  before pagination apr 24
    #   @all_leaves = @all_leaves.paginate(page: params[:page], per_page: 5)
    # else
    #   @all_leaves = @all_leaves.first(5)
    # end

     @all_leaves = @all_leaves.paginate(page: params[:page], per_page: 5)

     total_count = @all_leaves.count
     per_page = 5
  ratio = (total_count.to_f / per_page).ceil

   if @all_leaves.empty?
    render json: { message: 'No records found' }, status: :ok
  else

        render json: { all_leaves: @all_leaves, total_pages: ratio }, status: :ok
      end
  end



  # GET /leaves/id
  def show
    render json: @leave, status: :ok
  end

  


  # POST /leaves
  def create
    #   params.reverse_merge!(user_id: @current_user.id) if params.present? 
     params.merge!(user_id: @current_user.id) if params.present?
    # params[:expert_id].present?
    @leave = Leave.new(leave_params)
    # binding.pry
   
    if @leave.save
       # binding.pry
      #  Notification.create(
      #   headings: 'Leave Request',
      #   # contents: "#{@current_user.first_name} #{@current_user.last_name} has submitted a leave request.",
      #    contents: "#{@current_user.name} has submitted a leave request.",
      #   # user_id: user_id.to_i,
      #   action_needed: true,
      #   notification_type: 'Leave Request',
      #   notification_type_id: @leave.id, 
      #   guest_id: @current_user.id,
      #   # user_id: @leave.user.id
      # ) 
     @notification =  Notification.create(
      headings: 'Leave Request',
      contents: "#{@current_user.name} has raised a leave request.",
      user_id: @leave.manager_id,
      action_needed: true,
      notification_type: 'Leave Request',
      notification_type_id: @leave.id,
      guest_id: @leave.user_id
    )
      # binding.pry
     render json: @leave, status: :created
    else
      render json: { errors: @leave.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /leaves/id
  def update
        # binding.pry
    if @leave.update(leave_params)
      Notification.create(
      headings: 'Leave Update',
      contents: "#{@current_user.name} has updated a leave request.",
      user_id: @leave.user_id,
      action_needed: true,
      notification_type: 'Leave Update',
      notification_type_id: @leave.id,
      guest_id: @leave.manager_id
    )

       # send_notification

      render json: @leave, status: :created
    else
      render json: { errors: @leave.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # DELETE /leaves/id
  def destroy
   if @leave.destroy
      render json: @leave, status: :created
    else
      render json: { errors: "Record not found or deleted.." },
             status: :unprocessable_entity
   end    
  end

  #  def approve
  #   @leave = Leave.find(params[:id])
  #   expiry = @leave.created_at + 24.hours
  #   time = Time.now

  #   if time < expiry
      
  #     @leave.update(approval: true)
  #     # @leave.update(approval: params[:approve])
  #     render json: { message: 'Leave has been approved.' }, status: :ok
  #   else
  #     render json: { message: 'Cannot approve leave.here Time limit exceeded.' }, status: :unprocessable_entity
  #   end
  # end

  def approve
    # binding.pry
  @leave = Leave.find(params[:id])

  expiry = @leave.created_at + 24.hours
  time = Time.now

  if time < expiry
    # binding.pry
    if params[:approve] == 'true'
      @leave.update(approval: true)

       Notification.create(
      headings: 'Leave Approval',
      contents: "Your leave request has been approved.",
       user_id: @leave.user_id,
      action_needed: true,
      notification_type: 'Leave Approval',
      notification_type_id: @leave.id,
      guest_id: @leave.manager_id
    )
      render json: { message: 'Leave has been approved.' }, status: :ok
    elsif params[:approve] == 'false'
      @leave.update(approval: false)

       Notification.create(
      headings: 'Leave Approval',
      contents: "Your leave request has been rejected.",
      user_id: @leave.user_id,
      action_needed: true,
      notification_type: 'Leave Rejected',
      notification_type_id: @leave.id,
      guest_id: @leave.manager_id
    )
      render json: { message: 'Leave approval has been removed.' }, status: :ok
    else
      render json: { message: 'Invalid value for approval parameter.' }, status: :unprocessable_entity
    end
  else
    render json: { message: 'Cannot approve leave. Time limit exceeded.' }, status: :unprocessable_entity
  end
end


  private

   def set_leave
    # binding.pry
      @leave = Leave.find_by_id(params[:id])
      if @leave.nil?
         render json: { errors: 'Does not exist' },
               status: :unprocessable_entity      
       elsif @leave.user_id == @current_user.id
        # elsif @leave.manager_id == @current_user.id
        @leave

      else 
        @leave = nil
         render json: { errors: 'Something went wrong...' },
               status: :unprocessable_entity          
      end  
   end

   def check_permission
     	expiry = @leave.created_at + 24.hours
     	time = Time.now
     
       if time < expiry
         @leave
       else
        @leave = nil
         render json: { message: 'Something went wrong...' },
               status: :unprocessable_entity           
       end	
   end	

  def leave_params
    params.permit(:leave_purpose,:start_date,:end_date,:type_of_leave,:approval,:manager_id, :number_of_leaves, :user_id)
  end

    def serialization_options
      { params: { host: request.protocol + request.host_with_port} }
    end

    #  def send_notification
    #    registration_ids = ['dbZ3L2de6It-zxcBb7aPqr:APA91bHD2yeWBmROb3qlpVVqqd2yy2c9pUwHeoP3zedLn3NuyROl52FJkBJ01_XuNbg0mpQWuCuZoCT17B69po7HpPjWVXjV5VWZovRaQnNvr9Vk3TgGTB5XumG-ZIefQKj5C5krnw2o']

    #     options = {
    #       priority: 'high',
    #       notification: {
    #         title: 'Leave Approval',
    #         body: "Your leave request has been created.",
    #       # headings: 'Leave Approval',
    #       # contents: "Your leave request has been rejected.",
    #         # message: params[:message],
    #          sound: 'default'       
    #       }
    #     }
    #     # Replace 'your_server_key' with your actual FCM server key
    #        fcm = FCM.new('AAAAO0uGhd8:APA91bE4bQXfVJCII1XjpY6HKd4bqKsbNlQC2Ej79z68cxlPCIj_1awt53jA0g_w2wEo6x7tBPttERlkHqxXregjSBcuY2ri9v2xPYwpD0DcMfjB4yfbic8e7bxhLJ5hZAalNFI-hOLv')

    #      # fcm = FCM.new('AAAAxCLqJdc:APA91bEfByPx1BgsCYtiAJdhYZWAXI2ZhgfdpEKaAJ6TjxG4h-3StzAHNuj54lCtKP9-ExWdrOHw-_7MktPY7i_rzDEiLlhOoWd-IthA15VyE6z-JwoEcDAwZb-19zEwzDqdDZjkL-kz')

    #     response = fcm.send(registration_ids, options)
        
    #   # binding.pry
    #   # $a
    # end

   
end

