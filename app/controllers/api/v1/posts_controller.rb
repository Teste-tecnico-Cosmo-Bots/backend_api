class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]

  def show
    authorize @post
    render json: @post
  end

  def create
    @post = current_user.posts.build(post_params)
    authorize @post

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

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
