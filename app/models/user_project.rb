  class UserProject < ApplicationRecord
    self.table_name = :user_projects
   validates_uniqueness_of :user_id, scope: :project_id  
  end
  