class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  # before_action :authorize_user, only: [:show, :update, :destroy]
  before_action :authenticate_user!, only: [:index]

  def index
    if params[:page]
      @users = User.page(params[:page]).per(10)
    else
      @users = User.all
    end

    render json: @users
  end

  def show
    render json: @user
  end

  def create
    @user = User.new(user_params)
    authorize @user

    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    head :no_content
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def authorize_user
    authorize @user
  end

  def authorize_users
    authorize User
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :nome, :isAdmin, :isActive, :photo)
  end
end
