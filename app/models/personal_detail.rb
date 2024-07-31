class PersonalDetail < ApplicationRecord
  # self.table_name = "personal_details"
  belongs_to :user

  validates :first_name, :date_of_birth, :gender, :nationality,:marital_status,:mobile_number,:company_email,:personal_email,:present_address,:user_id,:aadhar_card_number,:pan_card_number, presence: true
  validates :mobile_number,:company_email,:personal_email,:user_id,:aadhar_card_number,:pan_card_number, uniqueness: true

end
