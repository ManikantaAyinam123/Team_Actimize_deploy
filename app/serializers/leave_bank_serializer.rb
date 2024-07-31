class LeaveBankSerializer < ActiveModel::Serializer
    # attributes :id,:year,:casual_leaves,:sick_leaves,:taken_casual_leaves,:taken_sick_leaves,:remaining_casual_leaves,:remaining_sick_leaves
       attributes :id, :expert_id, :year, :casual_leaves, :sick_leaves, :other_leaves,
             :taken_casual_leaves, :taken_sick_leaves, :taken_other_leaves,
             :remaining_casual_leaves, :remaining_sick_leaves, :remaining_other_leaves,
             :created_at, :updated_at
     def taken_casual_leaves
      leave_type = "Casual"
      @taken_casual_leaves = calculation(leave_type)
       return @taken_casual_leaves
      # calculation("Casual")
     end

     def taken_sick_leaves
     
      leave_type = "Sick"
      @taken_sick_leaves = calculation(leave_type)
       return @taken_sick_leaves
      # calculation("Sick")
     end

    def taken_other_leaves
      leave_type = "Other"
      calculation(leave_type)
       # calculation("Other")
    end

     def remaining_casual_leaves
      object.casual_leaves.to_i - taken_casual_leaves.to_i if object.casual_leaves
    end

    def remaining_sick_leaves
          
      object.sick_leaves.to_i - taken_sick_leaves.to_i if object.sick_leaves
    end

    def remaining_other_leaves
      object.other_leaves.to_i - taken_other_leaves.to_i if object.other_leaves
    end

   
     def calculation(leave_type)

       start_date = Date.today.at_beginning_of_year
       end_date = Date.today.at_end_of_year
      
       leaves = Leave.where(user_id: object.expert_id,created_at: start_date..end_date,type_of_leave: leave_type,approval: true)
        

        a = leaves.pluck(:number_of_leaves).sum
   
        return a 
     end 

  end










#   class LeaveBankSerializer < ActiveModel::Serializer
#   attributes :id, :year, :casual_leaves, :sick_leaves, :taken_casual_leaves, :taken_sick_leaves, :remaining_casual_leaves, :remaining_sick_leaves

#   def taken_casual_leaves
#     leave_type = "Casual"
#     calculation(leave_type)
#   end

#   def taken_sick_leaves
#     leave_type = "Sick"
#     calculation(leave_type)
#   end
# #############
#   def taken_other_leaves
#     leave_type = "Other"
#     calculation(leave_type)
#   end

#   ##########
#   def remaining_casual_leaves
#     object.casual_leaves.to_i - taken_casual_leaves.to_i if object.casual_leaves
#   end

#   def remaining_sick_leaves
#     object.sick_leaves.to_i - taken_sick_leaves.to_i if object.sick_leaves
#   end

#   def remaining_other_leaves
#     object.other_leaves.to_i - taken_other_leaves.to_i if object.other_leaves
#   end

#   def calculation(leave_type)
#     start_date = Date.today.at_beginning_of_year
#     end_date = Date.today.at_end_of_year
#     leaves = Leave.where(user_id: object.user_id, created_at: start_date..end_date, type_of_leave: leave_type, approval: true)
#     leaves.pluck(:number_of_leaves).sum
#   end
#   # def calculation(leave_type)
#   #      start_date = Date.today.at_beginning_of_year
#   #      end_date = Date.today.at_end_of_year
#   #      leaves = Leave.where(user_id: object.user_id,created_at: start_date..end_date,type_of_leave: leave_type,approval: true)
#   #       # a = 0
#   #       a = leaves.pluck(:number_of_leaves).sum
   
#   #       return a 
#   #    end 
#   end




