class NotificationSerializer < ActiveModel::Serializer
  # attributes :id, :created_by, :headings, :contents, :app_url, :is_read, :read_at, :action_needed, :created_at,
               # :updated_at, :user_id, :guest_id, :notification_type, :notification_type_id


    attributes :id, :headings, :contents, :is_read, :created_at, :updated_at

    # def profile_pic
    # binding.pry
    #   object.user_id.profile_pic
    # end

  # def initialize(object, options = {})
  #   super
  #   # binding.pry
  #   @current_user = options[:user_id]
  # end

  # def profile_pic
  #   # binding.pry
  #   @current_user.profile_pic if @current_user
  # end
end
