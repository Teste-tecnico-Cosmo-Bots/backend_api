class Api::V1::ArticlesController < ApplicationController
  def index
    articles = Article.all
    render json: articles
  end

  def show
    article = Article.find(params[:id])
    render json: article
  end

  def create
    article = Article.new(
      title: art_params[:title],
      body: art_params[:body],
      author: art_params[:author]
    )

    if article.save
      render json: article, status: :created
    else
      render json: { error: "Internal server error" }, status: :internal_server_error
    end
  end

  def update
    article = Article.find(params[:id])
    if article.update(art_params)
      render json: article, status: :ok
    else
      render json: { error: "Internal server error" }, status: :internal_server_error
    end
  end

  def destroy
    article = Article.find(params[:id])
    article.destroy
    head :no_content
  end

  private

  def art_params
    params.require(:article).permit(:title, :body, :author)
  end
end
