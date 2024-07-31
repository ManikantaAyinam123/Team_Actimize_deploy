class NotificationsController < ApplicationController

	before_action :authorize_request

	

  # def index
  #   notifications = @current_user.notifications.order(created_at: :desc)
  #   render json: notifications, each_serializer: NotificationSerializer, status: :ok
  # end
	def index
	  notifications = @current_user.notifications.order(created_at: :desc)
	  unread_notification_count = notifications.unread.count
	  render json: {
	    notifications: ActiveModel::Serializer::CollectionSerializer.new(notifications, each_serializer: NotificationSerializer),
	    unread_notification: unread_notification_count
	  }, status: :ok
	end
# def mark_as_read
#     notification = Notification.find(params[:id])
#     notification.update(is_read: true)
#     render json: notification, status: :ok
#   end

  def mark_as_read
    notification = Notification.find(params[:notification_id])
    # binding.pry
    notification.mark_as_read!
    render json: notification, status: :ok
  end

  # def all_notifications
	# 	notifications = Notification.all.order(created_at: :desc)
	# 	# notifications = (Notification.all + ActivityTracker.all).sort_by(&:created_at).reverse
    # 	render json: notifications, each_serializer: NotificationSerializer, status: :ok
	# end

	# def indexactive
	# 	notifications = ActivityTracker.all.order(created_at: :desc)
    # 	render json: notifications, each_serializer: NotificationSerializer, status: :ok
	# end


	def check_allow
 
  if params[:allow_notification] == 'true'
    @current_user.update(notifications_allow: true)
    render json: { data: { user: @current_user, messages: "notification has been enabled"} }, status: :ok
  elsif params[:allow_notification] == 'false'
    @current_user.update(notifications_allow: false)
    render json: { messages: "notification has been disabled" }, status: :ok
  else
    render json: { error: "Invalid value for 'approve' parameter" }, status: :unprocessable_entity
  end
end 

	def update_device_token
      # binding.pry
   

    device_token = params[:device_token]

    if device_token.present?
      @current_user.notification_devices.find_or_create_by(device_token: device_token)
      render json: { message: "FCM token updated successfully" }, status: :ok
    else
      render json: { error: "FCM token is missing" }, status: :unprocessable_entity
    end
  end
end
