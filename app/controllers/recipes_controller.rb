class RecipesController < ApplicationController
  before_action :find_recipe, only: [:show, :edit, :update, :destroy, :upvote, :favorite]
	before_action :authenticate_user!, except: [:index, :show,:home]

	def index
    if params[:tag]
      @recipe=Recipe.all.tagged_with(params[:tag])
    else
      @search=Recipe.search do
        fulltext params[:search]
      end
      @recipe=@search.results
    end
	end
  def home
    @recipe=Recipe.all.order("created_at DESC")
  end

	def show
	end

	def new
		@recipe = current_user.recipes.build
	end

	def create
		@recipe = current_user.recipes.build(recipe_params)

		if @recipe.save
			redirect_to @recipe, notice: "Successfully created new recipe"
		else
			render 'new'
		end
	end

	def edit
    if current_user.email!=@recipe.user.email
      redirect_to root_path
    end
	end

	def update
		if @recipe.update(recipe_params)
			redirect_to @recipe
		else
			render 'edit'
		end
	end

	def destroy
		@recipe.destroy
		redirect_to root_path, notice: "Successfully deleted recipe"
	end

  def upvote
    @recipe.upvote_by current_user
    redirect_to :back
  end

  def favorite
    type = params[:type]
    if type == "favorite"
      current_user.favorites << @recipe
      redirect_to :back, notice: 'Added to favorites :) '

    elsif type == "unfavorite"
      current_user.favorites.delete(@recipe)
      redirect_to :back, notice: 'Removed from favorites'

    else
      # Type missing, nothing happens
      redirect_to :back, notice: 'Nothing happened.'
    end
  end

  def favindex
    @recipe=current_user.favorites.all
  end

	private

	def recipe_params
		params.require(:recipe).permit(:title, :description,:tag_list,:image,ingredients_attributes: [:id, :name, :_destroy], directions_attributes: [:id, :step, :_destroy])
	end

	def find_recipe
		@recipe = Recipe.find(params[:id])
	end
end
