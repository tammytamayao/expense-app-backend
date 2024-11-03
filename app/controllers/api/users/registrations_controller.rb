class Api::Users::RegistrationsController < Devise::RegistrationsController
    respond_to :json
  
    # POST /api/users
    def create
      build_resource(sign_up_params)
  
      if resource.save
        render json: resource, status: :created
      else
        render json: resource.errors, status: :unprocessable_entity
      end
    end
  
    private

    def sign_up_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
  end
  