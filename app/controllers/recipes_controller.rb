class RecipeController < ApplicationController

  def index
    render json: Recipe.all
  end

  def create
    recipe = User.find_by(id: session[:user_id]).recipes.create!(recipe_params)
    render json: recipe, status: :created
  end

  private
  def recipe_params
    params.permit(:title, :instructions, :minutes_to_complete)
  end
end
