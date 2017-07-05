class SearchController < ApplicationController
	def index
		if params[:term] != nil
			@articles = Article.search params[:term]
			render json: @articles.to_json
		end
	end
  
  def search  	
  	if params[:query].nil?
    	@articles = []
  	else
    	@articles = Article.search params[:query]
  	end
  end
end
