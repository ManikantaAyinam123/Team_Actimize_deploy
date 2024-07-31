class LeaveSerializer < ActiveModel::Serializer
  attributes :id, :manager_id, :user_id,:leave_purpose,:start_date,:end_date,:type_of_leave,:approval


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
