class Api::Users::SessionsController < ApplicationController
    respond_to :json
  
    def create
      email = params.dig(:user, :email)
      password = params.dig(:user, :password)
      
      user = User.find_for_database_authentication(email: email)
  
      if user&.valid_password?(password)
        sign_in(user)
        render json: { message: 'Logged in successfully', user: user }, status: :ok
      else
        render json: { message: 'Invalid email or password' }, status: :unauthorized
      end
    end
  
    def destroy
      sign_out(current_user)
      render json: { message: 'Logged out successfully' }, status: :ok
    end
  end
  