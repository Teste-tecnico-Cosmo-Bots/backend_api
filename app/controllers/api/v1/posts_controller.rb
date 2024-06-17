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
          only: [:id,:title, :content, :created_at, :updated_at],
          include: { user: { only: [:id, :nome, :created_at, :updated_at] } }
        },
        user: { only: [:id, :nome, :created_at, :updated_at] }
      },
      methods: [:formatted_created_at_long, :formatted_created_at]
    )
  end
  
  def show
    render json: @post.as_json(
      include: {
        user: { only: [:id, :nome, :created_at, :updated_at] },
        comments: {
          only: [:id,:title, :content, :created_at, :updated_at],
          methods: [:formatted_created_at],
          include: { user: { only: [:id, :nome, :created_at, :updated_at] } },
        },
      },
      methods: [:formatted_created_at_long],
    )
  end
  
  def create
    @post = Post.new(
      title: post_params[:title],
      description: post_params[:description],
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
    @post.assign_attributes(post_params)

    if @post.save
      render json: @post.as_json(
        include: {
          user: { only: [:id, :nome, :created_at, :updated_at] },
          comments: {
            only: [:id, :title, :content, :created_at, :updated_at],
            methods: [:formatted_created_at],
            include: { user: { only: [:id, :nome, :created_at, :updated_at] } }
          }
        },
        methods: [:formatted_created_at_long]
      )
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
    render status: 200
  end
  

  private

  def set_post
    @post = Post.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Post not found" }, status: :not_found
  end

  def post_params
    params.require(:post).permit(:title, :content, :description)
  end

  def one_params
    params.require(:post).permit(:id)
  end
end
