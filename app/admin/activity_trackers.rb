ActiveAdmin.register ActivityTracker do



  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
   permit_params :created_by, :headings, :contents, :app_url, :is_read, :read_at, :action_needed, :guest_id, :notification_type, :notification_type_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:created_by, :headings, :contents, :app_url, :is_read, :read_at, :user_id, :action_needed, :guest_id, :notification_type, :notification_type_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end


   index do
    selectable_column
    id_column
    column :headings
    column :contents
    column :action_needed
    column :notification_type
    column :notification_type_id
    column :guest_id
    actions
  end

  
end
