class ArticlesController < ApplicationController
  include ActionView::Helpers::DateHelper 
  before_action :authenticate_user!
  def index
  	@articles = Article.all
    respond_to do |format|
      format.html
      format.js
    end
  end
 
  def show
  	@article = Article.find(params[:id])
  end

  def new
  	@article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
  	@article =Article.new(article_params)
    @article.user_id = current_user.id
  	if @article.save
  		redirect_to articles_path, :notice =>"Your article was saved successfully"
  	else
  		@articles = Article.all
  		render 'new'
  	end
  end

  def update
  	@article = Article.find(params[:id])
    if is_correct_user?(@article.user_id) 
      @article.update(article_params)
      redirect_to articles_path, :notice => "Your article was updated successfully"
    else
      redirect_to articles_path, :notice => "Unauthorized to edit!"
    end
  end

  def destroy
  	@article = Article.find(params[:id])
    if is_correct_user?(@article.user_id)
      @article.destroy
      redirect_to articles_path, :notice => "Your article was deleted successfully"
    else
      redirect_to articles_path, :notice => "Unauthorized to delete!"
    end
  end
helper_method :is_correct_user?
  def is_correct_user?(user_id)
    (user_id == current_user.id) ? true : false
  end
  private 
  def article_params
	  params.require(:article).permit(:title, :content)
	end
end
