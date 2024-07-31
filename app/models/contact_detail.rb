class ContactDetail < ApplicationRecord
  validates :address,:mobile_number,:name,:relationship, presence: true
  belongs_to :user

end
