Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "personal_details#welcome"  
  resources :users
  resources :personal_details
  resources :emergency_details
  resources :family_details
  resources :work_experiences
  resources :skills
  resources :tasks
  resources :projects
  resources :hours_entry do
    collection do
      get :current_week
    end
   end 
   resources :hours_entry
   
   resources :holidays
  
                  
  resources :leave_bank
  resources :taxes
   # resources :bank_details
   post '/users/:id/bank_details', to: 'bank_details#create'
  resources :leaves

  post '/login', to: 'authentication#login'
  get '/welcome', to: 'personal_details#welcome'

# resources :dashboard
  get '/dashboard', to: 'dashboard#dashboard'
  post '/profile_pic_change', to:'personal_details#profile_pic'

  get '/leaves_all', to:'leaves#all_leaves'

  # resources :leaves do
  #   collection do
  #     get 'all', to: 'leaves#all_leaves'
  #   end
  # end

  # resources :leaves do
  #   member do
  #     put 'approve' 
  #   end
  # end

  # get '/all_pers_detail', to: 'personal_details#all_personal_details'
  
  # get '/all_proj',to: 'projects#all_projects'
  get '/birthdays', to: 'birthdays#birthday_date'
 
  
  get '/all_employees', to: 'experts#all_employees'
 
  get '/all_employees_gadget', to: 'experts#all_employees_gadgets'



  resources :experts
  resources :leaves do
    member do
      put 'approve' 
    end
  end
  resources :gadgets
  resources :performance_appreciation
  
  resources :schedules_and_events
  resources :relieving_details
  resources :expert_leave_banks
  resources :certificate_verifications
  # resources :attendances
  # get 'attendances/monthly_status', to: 'attendances#monthly_status'
    resources :attendances, only: [:index, :create, :show, :update, :destroy] do
  collection do
    get 'monthly_status'
  end
end

  get '/all_users_with_skills', to: 'skills#all_users_with_skills'
  get '/search_users_related_to_skill', to: 'skills#search_users_related_to_skill'
   get 'manager_dashboard', to: 'dashboard#manager_dashboard'
   get '/user_profiles', to: 'users#user_profiles'
  get '/sidebar_profile_card', to: 'skills#sidebar_profile_card'

   get '/user_names', to: 'users#user_name'
  
   resources :merits
   resources :performance_appreciation
   # get 'all_experts/', to: 'attendances#monthly_status'
   get '/all_exp', to: 'users#all_experts'
   get '/search_by_name', to: 'users#search_by_name'
   get '/search_by_name_merits', to: 'merits#search_by_name_merits'
   get '/search_by_name_appreciation', to: 'performance_appreciation#search_by_name_appreciation'
   get 'users/:id/date_of_joining', to: 'users#date_of_joining', as: 'user_date_of_joining'
  resources :users do
    member do
        get 'personal_details'
        get 'family_details'
        get 'emergency_details'
        get 'work_experiences'
        get 'skills'
        get 'leave_banks'
        get 'projects'
        get 'bank_details'
    
    end
  end

  resources :bank_details, only: [:update] do
    member do
      put 'approve' 
    end
  end

  #  resources :dashboard do
  #   collection do
  #     get :all_users_previous_weeks_totals
  #     get :all_users_previous_month_totals
  #   end
  # end

  # # get '/all_users_last_week_totals', to: 'dashboard#all_users_last_week_totals'
   get '/all_users_previous_weeks_totals', to: 'dashboard#all_users_previous_weeks_totals'

  #   # get '/all_users_previous_weeks_totals', to: 'dashboard#all_users_previous_weeks_totals'
     get '/all_users_previous_month_totals', to: 'dashboard#all_users_previous_month_totals'

      get '/user_daily_status', to: 'dashboard#user_daily_status'
    
     get '/all_projects', to: 'projects#projects'

     # get '/all_leave_banks', to: 'leave_banks#all_leave_banks'
  get '/all_leave_banks', to: 'leave_bank#all_leave_banks'

   get '/notifications', to: 'notifications#index'
    # get '/notificationsact', to: 'notifications#indexactive'
    # get '/all_notifications', to: 'notifications#all_notifications'
    
   put '/mark_as_read', to: 'notifications#mark_as_read'

   # patch '/allow/:id', to: 'users#update_allow'
   # patch '/users/:id/allow', to: 'users#check_allow'
   put '/notifications_allow', to: 'notifications#check_allow'

    # patch '/notifications/:id/mark_as_read', to: 'notifications#mark_as_read'

     get '/paginate_users_list', to: 'skills#paginate_users_list'

       # post 'users/:id/update_device_token', to: 'users#update_device_token', as: 'update_fcm_token'

      post '/update_device_token', to: 'notifications#update_device_token'

  get '/management_numbers', to: 'users#management'

end
