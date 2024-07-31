class WorkExperienceSerializer < ActiveModel::Serializer
  attributes :id,:user_id, :organization_name, :designation, :date_of_join, :date_of_end, :experience, :created_at, :updated_at

  def experience
    join_date = Date.parse(object.date_of_join)
    end_date = Date.parse(object.date_of_end)

    years_diff = end_date.year - join_date.year
    months_diff = end_date.month - join_date.month

     if months_diff < 0
      years_diff -= 1
      months_diff += 12
    end

     { years: years_diff, months: months_diff }
   

    # "years: #{years_diff}, months: #{months_diff}"
  end  
end
