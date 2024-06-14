class Api::V1::PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy, :get_with_comments]
  skip_before_action :authenticate_user!, only: [:index, :show, :get_with_comments]

  def index
    if params[:page]
      @posts = Post.includes(:comments, :user).order(created_at: :desc).page(params[:page]).per(10)
    else
      @posts = Post.includes(:comments, :user).order(created_at: :desc)
    end
  
    render json: @posts.as_json(
      include: {
        comments: {
          only: [:id, :content, :created_at, :updated_at],
          include: { user: { only: [:id, :nome, :created_at, :updated_at] } }
        },
        user: { only: [:id, :nome, :created_at, :updated_at] }
      }
    )
  end
  

  def show
    render json: @post
  end

  def create
    @post = Post.new(
      title: post_params[:title],
      content: post_params[:content],
      user: current_user
    )

    if @post.save
      render json: @post, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def update
    authorize @post

    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @post
    @post.destroy
    head :no_content
  end

  def get_with_comments
    # posts = Post.includes(:comments).order(created_at: :desc)
  
    render status: 200
  end
  

  private

  def set_post
    @post = Post.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Post not found" }, status: :not_found
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
