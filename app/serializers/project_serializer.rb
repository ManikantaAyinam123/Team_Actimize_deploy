class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :project_name,:status,:start_date,:end_date,:assigned_by,:members

  
  
   def assigned_by
    
      object.user.username
   end 

   def members
    exclude_columns = ['password_digest', 'roles', 'created_at','updated_at']
    columns = User.attribute_names - exclude_columns      
    object.assigned_users.select(columns)
    
   end 

  
  
end
