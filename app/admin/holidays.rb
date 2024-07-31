ActiveAdmin.register Holiday do
  permit_params :title, :date
  
   
  index do
    selectable_column
    id_column
    column :title
    column :date
    column :created_at
    column :updated_at
    
    actions
   end

    form do |f|
    f.inputs 'Holiday Details' do
      f.input :title
      f.input :date, as: :datepicker
     
    end
      f.actions
    end
    
    show do
    attributes_table do
      row :title
      row :date
     
    end
  end
end
