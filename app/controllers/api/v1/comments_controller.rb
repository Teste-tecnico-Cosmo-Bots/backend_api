class Api::V1::CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :update, :destroy]
  before_action :authenticate_user!, only: [:create]

  def index
    if params[:page]
      @comments = Comment.order(created_at: :desc).page(params[:page]).per(10)
    else
      @comments = Comment.order(created_at: :desc)
    end
    render json: @comments
  end
  
  def show
    render json: @comment
  end

  def create
    @comment = Comment.new(
      body: params[:body],
      post: post_params,
      user: current_user
    )

    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    head :no_content
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Comment not found" }, status: :not_found
  end

  def post_params
    Post.find_by(id: params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
