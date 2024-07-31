class CertificateVerification < ApplicationRecord

 
  validates :message, presence: true
  validates :note, presence: true


  belongs_to :expert, class_name: 'User', foreign_key: 'expert_id'
  belongs_to :user
end
