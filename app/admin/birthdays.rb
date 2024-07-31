ActiveAdmin.register Birthday do
    permit_params :title, :date

    form do |f|
      f.inputs 'Birthday Details' do
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
    
