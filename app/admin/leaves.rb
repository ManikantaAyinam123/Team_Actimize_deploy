ActiveAdmin.register Leave do
    permit_params :leave_purpose, :start_date, :end_date, :type_of_leave, :approval, :user_id, :number_of_leaves, :manager_id
    
 
  index do
    selectable_column
    id_column
    column :manager
    column :user
    column :leave_purpose
    column :start_date
    column :end_date
    column :number_of_leaves
    column :type_of_leave
    column :approval do |leave|
      if leave.approval
        status_tag 'Yes'
      else
        status_tag 'No'
      end
    end
    actions defaults: true do |leave|
      if leave.approval
        link_to 'Reject', reject_admin_leave_path(leave), method: :put, class: 'reject-button member_link'
      else
        link_to 'Approve', approve_admin_leave_path(leave), method: :put, class: 'approve-button member_link'
      end
    end
  end

  member_action :approve, method: :put do
    leave = Leave.find(params[:id])
    leave.update(approval: true)
    redirect_to admin_leaves_path, notice: 'Leave has been approved.'
  end

  member_action :reject, method: :put do
    leave = Leave.find(params[:id])
    leave.update(approval: false)
    redirect_to admin_leaves_path, notice: 'Leave has been rejected.'
  end

  
    show do
    attributes_table do
      
      row :leave_purpose
      row :start_date
      row :end_date
      row :number_of_leaves
      row :type_of_leave
      row :approval
      row :user
    end
  end

  form do |f|
    f.inputs 'Leave Details' do
      
      f.input :leave_purpose
      f.input :start_date
      f.input :end_date
      f.input :number_of_leaves
      f.input :type_of_leave
      f.input :approval
      f.input :user
      f.input :manager
    end
    f.actions
  end

end
  
