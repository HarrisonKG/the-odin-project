class ArticlesController < ApplicationController
	# conventionally: index, show, new, 
	# edit, create, update, destroy

#	http_basic_authenticate_with name: "name", password: "password", 
#	except: [:index, :show]

	def index
		@articles = Article.all
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
		@article = Article.new(article_params)

		if @article.save
			flash.notice = "Article '#{@article.title}' created!"
			redirect_to @article
		else
			render 'new'
		end
	end

	def update
		@article = Article.find(params[:id])

		if @article.update(article_params)
			flash.notice = "Article '#{@article.title}' updated!"
			redirect_to @article
		else
			render 'edit'
		end
	end

	def destroy
		@article = Article.find(params[:id])
		@article.destroy
		flash.notice = "Article '#{@article.title}' deleted!"
		redirect_to articles_path
	end

	

# other example has this saved into app/helpers
# articles_helper.rb w/o private designation
# and'include ArticlesHelper' just below class name in this doc

	private
	def article_params
		params.require(:article).permit(:title, :text, :tag_list)
	end

end
