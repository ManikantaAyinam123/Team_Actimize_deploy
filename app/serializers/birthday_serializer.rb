  class BirthdaySerializer < ActiveModel::Serializer

  attributes :first_name, :last_name, :date_of_birth, :designation, :profile_pic 


  def designation
   
      object.user.designation
  end

  def date_of_birth
   
    object.date_of_birth.to_date.strftime("%d %B")
    
  end 

end
