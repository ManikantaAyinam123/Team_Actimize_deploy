class User < ApplicationRecord

    # default_scope { where(active: true) }

     scope :active, -> { where(active: true).where("('Employee' = ANY (roles) OR 'Management' = ANY (roles))") }

     
  validates :username,:employee_id_number, presence: true, uniqueness: true
 VALID_EMAIL_REGEX= /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i
 validates :email , presence: true,uniqueness:{case_sensetive:false},
    format:{with:VALID_EMAIL_REGEX,multiline:true}


  validates :roles,:designation,:name, presence: true
  has_secure_password
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }


  has_one :personal_detail, dependent: :destroy
  has_many :contact_details,dependent: :destroy
  has_many :work_experiences,dependent: :destroy
  has_many :skills,dependent: :destroy
  has_many :tasks,dependent: :destroy
  has_many :hours_entries,dependent: :destroy
  #has_many :projects,dependent: :destroy
  has_and_belongs_to_many :assigned_projects, join_table: 'user_projects',class_name: 'Project'
  has_one :bank_detail, dependent: :destroy
  has_many :leaves, dependent: :destroy
  has_many :leave_banks, dependent: :destroy, foreign_key: 'expert_id'

  has_many :created_leave_banks, dependent: :destroy, class_name: 'LeaveBank', foreign_key: 'user_id'


  has_many :birthdays
  has_many :holidays
  # has_many :hours_entries
     
   # ROLES = %W{employee manager}

  def employee?
     roles.map(&:capitalize).include? "Employee"
    # roles == 'employee'
   # expert == true
  end

  def manager?
     roles.map(&:capitalize).include? "Management"
    # roles == 'manager'
   # management == true
  end

  has_many :family_details
  has_many :emergency_details
  has_many :bank_details
  has_many :projects
   # has_many :merits
   has_many :merits, dependent: :destroy, foreign_key: 'expert_id'

   has_many :created_merits, dependent: :destroy, class_name: 'Merit', foreign_key: 'user_id'

   has_many :performance_appreciations, dependent: :destroy, foreign_key: 'expert_id'

   has_many :created_performance_appreciations, dependent: :destroy, class_name: 'PerformanceAppreciation', foreign_key: 'user_id'

   has_many :certificate_verifications, dependent: :destroy, foreign_key: 'expert_id'

   has_many :created_certificate_verifications, dependent: :destroy, class_name: 'CertificateVerification', foreign_key: 'user_id'

   has_many :relieving_details, dependent: :destroy, foreign_key: 'expert_id'

   has_many :created_relieving_details, dependent: :destroy, class_name: 'RelievingDetail', foreign_key: 'user_id'
   
   has_many :schedules_and_events

   has_many :gadgets, dependent: :destroy, foreign_key: 'expert_id'

   has_many :created_gadgets, dependent: :destroy, class_name: 'Gadget', foreign_key: 'user_id'
   
   has_many :attendances, dependent: :destroy, foreign_key: 'expert_id'

   has_many :created_attendances, dependent: :destroy, class_name: 'Attendance', foreign_key: 'user_id'
   
   has_many :notifications

   has_many :notification_devices

end
