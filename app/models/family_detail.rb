class FamilyDetail < ContactDetail
  validates_uniqueness_of :email, scope: :user_id
  validates_uniqueness_of :mobile_number, scope: :user_id	
end
