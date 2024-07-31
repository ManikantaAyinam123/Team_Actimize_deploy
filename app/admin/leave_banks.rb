ActiveAdmin.register LeaveBank do

  permit_params :user_id, :year, :casual_leaves, :sick_leaves, :other_leaves, :expert_id   
 
  
  

  
  index do
    selectable_column
    id_column
    column :expert
    column :user
    column :year
    column :casual_leaves
    column :sick_leaves
    column :other_leaves
    column :taken_casual_leaves do |leave_detail|
      LeaveBankSerializer.new(leave_detail).taken_casual_leaves
    end
    column :taken_sick_leaves do |leave_detail|
      LeaveBankSerializer.new(leave_detail).taken_sick_leaves
    end

    column :taken_other_leaves do |leave_detail|
      LeaveBankSerializer.new(leave_detail).taken_other_leaves
    end

    column :remaining_casual_leaves do |leave_detail|
         
      LeaveBankSerializer.new(leave_detail).remaining_casual_leaves
    end
    column :remaining_sick_leaves do |leave_detail|
      LeaveBankSerializer.new(leave_detail).remaining_sick_leaves
    end

    column :remaining_other_leaves do |leave_detail|
      LeaveBankSerializer.new(leave_detail).remaining_other_leaves
    end


    actions 
  end 

end

