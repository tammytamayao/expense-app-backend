class Api::UsersController < ApplicationController
    def create
        @user = User.new(user_params)
        if @user.save
            render json: { message: 'User created successfully' }, status: :created
        else
            render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def login
        @user = User.find_by(username: params[:username])
        if @user&.authenticate(params[:password])
            render json: { message: 'Login successful', user: { username: @user.username } }, status: :ok
        else
            render json: { error: 'Invalid credentials' }, status: :unauthorized
        end
    end

    def logout
        # NOTE: extendable feature using sessions and tokens
        render json: { message: 'Logout successful' }, status: :ok
    end
    
    private

    def user_params
        params.require(:user).permit(:username, :password)
    end
end
