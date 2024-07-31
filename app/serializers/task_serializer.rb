  class TaskSerializer < ActiveModel::Serializer
  attributes :id,:daily_status,:task_name,:task_progress,:description,:worked_hours,:total_hours,:created_at,:updated_at,:permissions

   def permissions
    
      expiry = object.created_at + 24.hours
      time = Time.now
       if time < expiry
         return permissions = true
       else 
         return permissions = false
       end 
   end  

end
