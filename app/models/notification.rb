class Notification < ApplicationRecord

  belongs_to :user, class_name: 'User'
  # belongs_to :notificable, polymorphic: true

  validates :headings, :contents, :user_id, presence: true

      after_create :send_notification

  scope :unread, -> {where(is_read: false)}
  def mark_as_read!
    update(is_read: true)
  end  
  def send_notification

        # user_ids = self.user_id
      
      @user = User.find_by_id(self.user_id)
        # binding.pry
       if @user.notifications_allow
     registration_ids =  NotificationDevice.where(user_id: @user.id).pluck(:device_token)
           # binding.pry

      options = {
          priority: 'high',
          notification: {
            title: headings,
            body: contents,
            sound: 'default'       
          }
        }
        
           fcm = FCM.new('AAAAO0uGhd8:APA91bE4bQXfVJCII1XjpY6HKd4bqKsbNlQC2Ej79z68cxlPCIj_1awt53jA0g_w2wEo6x7tBPttERlkHqxXregjSBcuY2ri9v2xPYwpD0DcMfjB4yfbic8e7bxhLJ5hZAalNFI-hOLv')
           # fcm = FCM.new('AAAAxELYM4k:APA91bGBXbDh28wW7tKRhqTuFHRaGZURzL2W689knsnkB5C5IL-ctf7mZERvblzyqSqfzFZRiZnAskMZGs_rbizTCfqht9uBaJJ-_Hoen0dTGZzfFgIR5auHKLxC7gKl-sHnGpXWMjZh')

         # fcm = FCM.new('AAAAxCLqJdc:APA91bEfByPx1BgsCYtiAJdhYZWAXI2ZhgfdpEKaAJ6TjxG4h-3StzAHNuj54lCtKP9-ExWdrOHw-_7MktPY7i_rzDEiLlhOoWd-IthA15VyE6z-JwoEcDAwZb-19zEwzDqdDZjkL-kz')
          # binding.pry
        response = fcm.send(registration_ids, options)

        # render json: response
        end
      end



end
