class AttendanceSerializer < ActiveModel::Serializer
   # attributes :id, :date, :user_id,
    attributes :id, :user_id,:date,:experts
    def experts
      experts_array = []
      array = []
      array.push(object.present,object.holiday,object.leave) 
      # array = array.flatten.uniq
      array = array.flatten.uniq.sort { |a, b| b <=> a }
       
        array.map do |expert_id|
          value =    { 
        expert_id: expert_id,
        present: object.present.include?(expert_id),
        leave: object.leave.include?(expert_id),
        holiday: object.holiday.include?(expert_id),
          }
 
        experts_array << value  
        
     end
       experts_array
     # experts_array.sort_by { |h| -h[:expert_id] }
    end   

     
 end

 