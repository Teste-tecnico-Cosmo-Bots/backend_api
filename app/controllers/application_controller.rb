# app/controllers/application_controller.rb

class ApplicationController < ActionController::API
    include Pundit
  
    before_action :authenticate_user!
  
    private
  
    def authenticate_user!
      token = request.headers['Authorization']&.split(' ')&.last
      return render json: { error: 'Não há um token' }, status: :unauthorized unless token
  
      decoded_token = JsonWebToken.decode(token)
      return render json: { error: 'Token inválido' }, status: :unauthorized unless decoded_token
  
      @current_user = User.find(decoded_token[:user_id])
      return render json: { error: 'Usuário não existe' }, status: :unauthorized unless @current_user
    end
  
    def current_user
      @current_user
    end
  end
  