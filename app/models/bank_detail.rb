class BankDetail < ApplicationRecord
  belongs_to :user
  # has_many :notifications, as: :notificable

  validates :bank_name, :account_number,:user_id,:ifsc_code,:branch_name, presence: true
  validates :account_number,:user_id, uniqueness: true	
    
    

  
  
  
end
