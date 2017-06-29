class CommentsController < ApplicationController
	before_action :is_correct_user?, only: [:destroy]
	def create
		@article = Article.find(params[:article_id])
		@comment = @article.comments.create(comment_params)
		@comment.user_id = current_user.id;
		if @comment.save
			respond_to do |format|
				format.html 
				format.js
			end
		else
			redirect_to articles_path, :notice =>"Comment is not valid"
		end
	end

	def destroy
		@article = Article.find(params[:article_id])
		@comment = @article.comments.find(params[:id])
		@comment.destroy
		redirect_to articles_path
	end

	private
	def comment_params
		params.require(:comment).permit(:body)
	end

	def is_correct_user?
    unless Article.find(params[:article_id]).comments.find(params[:id]).user_id == current_user.id
      flash[:notice] = 'Access denied as you are not owner of this Article'
      redirect_to articles_path
    end
  end

end
