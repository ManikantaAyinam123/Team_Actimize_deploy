ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation,:username,:designation,:employee_id_number, :active, :date_of_joining, :name, :roles
 


  # member_action :inactivate, method: :put do
  #     user = User.find(params[:id])
  #     user.update(active: false)
  #     redirect_to admin_users_path, notice: "User inactivated successfully."
  #  end 

  member_action :inactivate, method: :put do
    user = User.find(params[:id])
    user.update(active: !user.active)
    redirect_to admin_users_path, notice: "User #{user.active ? 'activated' : 'inactivated'} successfully."
  end

 


 
  


  index do
    selectable_column
    id_column
    column :email
    column :name
    column :username
    column :roles
    column :designation
    column :employee_id_number

    column :active do |user|
      status_tag(user.active? ? 'Yes' : 'No', class: user.active? ? 'ok' : 'error')
    end

    actions do |user|
      link_to user.active? ? 'Inactivate' : 'Activate', inactivate_admin_user_path(user), method: :put
    end
   end

  form do |f|
    f.inputs do
      f.input :email, include_blank: false
      f.input :name, include_blank: false
      f.input :username, include_blank: false
         f.input :roles, as: :tags, collection: ['Employee', 'Management', 'Client']
      # f.input :roles, :as => :tags, collection: ['Employee', 'Management', 'Client']
      # f.input :roles ,as: :select, collection: ["Employee","Management","Client"]
      f.input :designation
      f.input :employee_id_number
      # f.input :active
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  
    
controller do  
    def create
       
        roles = params[:user][:roles].split(",")
        email = params[:user][:email]
        designation = params[:user][:designation]
        password = params[:user][:password]
        password_confirmation = params[:user][:password_confirmation]
        employee_id_number = params[:user][:employee_id_number]
        username = params[:user][:username]
        namee = params[:user][:name]
        user = User.new(roles: roles, email: email,designation: designation,password: password,employee_id_number: employee_id_number,password_confirmation: password_confirmation,username: username,name: namee)
      if user.save
        
        redirect_to :action => "show", :id => user.id
      else
        err_msgs = user.errors.full_messages
       
           flash[:error] =  err_msgs
          
           redirect_to :action => "new"
      end     
    end   



  def update
        
      user = User.find(params[:id])
        roles = params[:user][:roles].split(",")
        email = params[:user][:email]
        designation = params[:user][:designation]
        password = params[:user][:password]
        password_confirmation = params[:user][:password_confirmation]
        employee_id_number = params[:user][:employee_id_number]
        username = params[:user][:username]
        namee = params[:user][:name]

      if user.update(roles: roles, email: email,designation: designation,password: password,employee_id_number: employee_id_number,password_confirmation: password_confirmation,username: username,name: namee)
           redirect_to :action => "show", :id => user.id
      
      else
       
           redirect_to :action => "edit", :id => user.id
      end     
  end

end
end


