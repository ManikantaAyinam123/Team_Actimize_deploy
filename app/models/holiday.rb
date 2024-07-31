class Holiday < Announcement
	
   validates :title, presence: true, uniqueness: { case_sensitive: false }

   validates_uniqueness_of :date
	
end