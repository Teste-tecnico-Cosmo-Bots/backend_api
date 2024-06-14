module Api
  module V1
    class RegistrationsController < Devise::RegistrationsController
      skip_before_action :authenticate_user!, only: [:create]

      def create
        build_resource(sign_up_params)

        resource.save
        render_resource(resource)
      end

      def update
        resource.update(account_update_params)
        render_resource(resource)
      end

      def destroy
        resource.destroy
        head :no_content
      end

      private

      def sign_up_params
        params.require(:user).permit(:email, :password, :password_confirmation, :nome)
      end

      def account_update_params
        params.require(:user).permit(:email, :password, :password_confirmation, :current_password)
      end

      def render_resource(resource)
        if resource.errors.empty?
          render json: resource
        else
          render json: resource.errors, status: :unprocessable_entity
        end
      end

    end
  end
end
