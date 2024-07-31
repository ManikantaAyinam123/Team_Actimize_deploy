class Expert < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true
  validates :role, presence: true
 
  validates :designation, presence: true
  validates :employee_id, presence: true, uniqueness: true



end
