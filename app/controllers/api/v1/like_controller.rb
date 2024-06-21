class Api::V1::LikeController < ApplicationController
    before_action :set_post, only: [:toggle_like]
    # skip_before_action :authenticate_user!, only: [:index, :show, :get_with_comments]
  
    def index
        @like = Like.order(created_at: :desc)
        render json: @like
    end
    
    def toggle_like
        like = Like.find_by(user: current_user, post: @post)
        
        if like
          like.destroy
          render json: { message: "Like removed" }, status: :ok
        else
            @like = Like.new(user: current_user, post: @post)
            if @like.save
                render json: { message: "Like added" }, status: :created
            else
                render json: @like.errors, status: :unprocessable_entity
            end
        end
      rescue ActiveRecord::RecordInvalid => e
        render json: { error: e.message }, status: :unprocessable_entity
    end

    private

    # def set_like
    #     @post = Post.find(params[:id])
    #   rescue ActiveRecord::RecordNotFound
    #     render json: { error: "Post not found" }, status: :not_found
    # end

    def set_post
    @post = Post.find(params[:post_id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Post not found" }, status: :not_found
      end
  end
  