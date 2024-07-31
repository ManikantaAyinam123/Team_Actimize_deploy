class AuthenticationController < ApplicationController
  before_action :authorize_request, except: :login

  # POST /auth/login
  # def login
  #   @user = User.find_by_email(params[:email])
  #   if @user&.authenticate(params[:password])
  #     token = JsonWebToken.encode(user_id: @user.id)
  #     time = Time.now + 24.hours.to_i
  #     render json: { token: token }, status: :ok
  #   else
  #     render json: { errors: 'Please enter valid Email/Password' }, status: :unauthorized
  #   end
  # end

  def login
    @user = User.find_by_email(params[:email])
    # binding.pry
    if @user&.authenticate(params[:password])
      if @user.active?
          
         token = JsonWebToken.encode(user_id: @user.id)
        
        render json: { token: token, roles: @user.roles, email: @user.email }, status: :ok
      else
        render json: { errors: 'Your account is not active. Please contact the administrator.' }, status: :unprocessable_entity
      end
    else
      render json: { errors: 'Please enter valid Email/Password' }, status: :unprocessable_entity
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end