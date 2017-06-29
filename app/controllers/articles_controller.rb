class ArticlesController < ApplicationController
  include ActionView::Helpers::DateHelper 
  before_action :authenticate_user!
  before_action :is_correct_user?, only: [:edit, :update, :destroy]

  def index
  	@articles = Article.all.paginate(page: params[:page], per_page: 3)
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
    @article.update(article_params)
    redirect_to articles_path, :notice => "Your article was updated successfully"   
  end

  def destroy
  	@article = Article.find(params[:id])
      @article.destroy
      redirect_to articles_path, :notice => "Your article was deleted successfully"
  end

  private 

  def article_params
	  params.require(:article).permit(:title, :content)
	end

  def is_correct_user?
    unless Article.find(params[:id]).user_id == current_user.id
      flash[:notice] = 'Access denied as you are not owner of this Article'
      redirect_to articles_path
    end
  end
end
