ActiveAdmin.register Project do
 permit_params :user_id, :project_name, :status, :start_date, :end_date, :assigned_by, :description, assigned_user_ids: []
  
  
  index do
    selectable_column
    id_column
   
    column :project_name
    column :status
    column :start_date
    column :end_date
    column :description
    column :assigned_by do |project|
    project.user.username
  end
    column :assigned_users
    
    
    actions
   end


   form do |f|
    f.inputs 'Project Details' do
      f.input :user, label: 'Project created by'
      f.input :project_name
       f.input :status
      f.input :start_date
      f.input :end_date
      f.input :description
      f.input :assigned_users, as: :select, collection: User.all, multiple: true
    end
    f.actions
  end

  show do
    attributes_table do
      row :project_name
      row :status
      row  :start_date
      row  :end_date
      row :description
      row :assigned_by do |project|
        project.user.name
      end
      row  :assigned_users, as: :select, collection: User.all, multiple: true
    end
    end
   controller do
    def create
      @project = Project.new(permitted_params[:project])
      if @project.save
      @members = params[:assigned_user_id].reject(&:empty?) if params[:assigned_user_ids].present?
     
      @members = User.where(id: @members).pluck(:id)
        if @members.any?
          assign_user
        end  
     
       redirect_to admin_project_path(@project)
      else
    
         flash[:error] = @project.errors.full_messages
         redirect_to :action => "new"
      end
    end
   end   

    def assign_user
    @members.each do |user|
      @user_project = UserProject.new(user_id: user,project_id: @project.id)
      if @user_project.save
          puts "user saved"
      else
        
        flash[:error] = user_project.errors.full_messages
        redirect_to :action => "new"
      end 
    end    
   end  
 end
