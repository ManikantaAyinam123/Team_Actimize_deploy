
class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  	rescue_from CanCan::AccessDenied do |exception|
       
    render json: { error: exception.message}
     end

     def current_ability
      @current_ability ||= Ability.new(@current_user)
    end

  def not_found
    render json: { errors: 'not_found' }
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
     
      @current_user = User.find(@decoded[:user_id])
     
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: "User not found" }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: "Invalid token" }, status: :unauthorized
    end
  end	
  
end
