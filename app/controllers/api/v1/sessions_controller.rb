class Api::V1::SessionsController < Devise::SessionsController
  skip_before_action :authenticate_user!, only: [:create]

  def create
    email = params[:email]
    password = params[:password]
    user = User.find_by(email: email)

    if user && user.valid_password?(password)
      token = generate_jwt_token(user)
      render json: { token: token }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  private

  def generate_jwt_token(user)
    JWT.encode({ user_id: user.id }, 'testedetoken', 'HS256')
  end
end
