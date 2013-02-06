class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    pic = params[:article].delete(:picture)
    pic = pic.read if pic

    article = Article.new(params[:article])
    article.picture = pic

    if article.save
      redirect_to root_path
    else
      flash.notice = article.errors.full_messages.first
      @article = article
      render 'articles/new'
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    article = Article.find(params[:id])

    pic = params[:article].delete(:picture)
    article.update_attributes(params[:article])

    pic = pic.read if pic
    article.update_attributes(picture: pic) if pic

    redirect_to root_path
  end

  def picture
    article = Article.find(params[:id])
    send_data(article.picture, type: 'image/jpg', disposition: 'inline')
  end
end
