class HoursEntryController < ApplicationController

  before_action :authorize_request
  before_action :set_entry, only: [:show, :edit, :update]
   before_action :check_week, only: [:create]
  # load_and_authorize_resource param_method: :entry_params


  def index
    
    @hours_entry = HoursEntry.where(user_id: @current_user.id).last if @current_user.hours_entries.present?
    
    c_date = @hours_entry.weekly_status["Monday"]["Date"].to_date if @hours_entry.present?
    
    date = Date.today.at_beginning_of_week
    if c_date == date
      render json: @hours_entry, status: :ok
    end     
  end

  # GET /hours_entries/id
  def show
    render json: @hours_entry, status: :ok
  end

  # POST /hours_entries
  def create
    
     
    params.merge!(user_id: @current_user.id,week_start_date:params[:weekly_status]["Monday"]["Date"].to_date) if params.present?
    @hours_entry = HoursEntry.new(entry_params)
    if @hours_entry.save
      render json: @hours_entry, status: :created
    else
      render json: { errors: @hours_entry.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /hours_entries/id
  def update
  	if @hours_entry.approval == false 
  	    if @hours_entry.update(entry_params)
  	      render json: @hours_entry, status: :created
  	    else
  	      render json: { errors: @hours_entry.errors.full_messages },
  	             status: :unprocessable_entity
  	    end
	  else
         render json: { message: 'Access Denied...' },
               status: :unprocessable_entity		
	  end    
  end



  def current_week
  	monday = Date.today.at_beginning_of_week  
  	tuesday = monday.next_day
  	wednesday = tuesday.next_day
  	thursday = wednesday.next_day
  	friday = thursday.next_day
  	saturday = friday.next_day
    @cur_week = [{id: 1, day:"Monday",date: monday.strftime("%d-%m-%Y")},{id: 2, day:"Tuesday",date: tuesday.strftime("%d-%m-%Y")},{id: 3, day:"Wednesday",date: wednesday.strftime("%d-%m-%Y")},{id: 4, day:"Thursday",date: thursday.strftime("%d-%m-%Y")},{id: 5, day:"Friday",date: friday.strftime("%d-%m-%Y")},{id: 6, day:"Saturday",date: saturday.strftime("%d-%m-%Y")}]
    render json: @cur_week, status: :ok  	
  end	


  private

   def set_entry
      @hours_entry = HoursEntry.find_by_id(params[:id])
      if @hours_entry.nil?
         render json: { errors: 'Does not exist' },
               status: :unprocessable_entity      
      elsif @hours_entry.user_id == @current_user.id
        @hours_entry
      else 
        @hours_entry = nil
         render json: { errors: 'Something went wrong...' },
               status: :unprocessable_entity          
      end  
   end

  def check_week
    
  	c_date = @current_user.hours_entries.last.weekly_status["Monday"]["Date"].to_date if @current_user.hours_entries.present?
  	date = Date.today.at_beginning_of_week
    
  	if c_date == date
      render json: { message: 'Already Exists...' },
               status: :unprocessable_entity 
    # else 
    #    render json: { message: 'Something went wrong...' },
    #            status: :ok                
  	end	
  end

  def entry_params
    params.permit(:user_id,:week_start_date,weekly_status: {})
  end

end

