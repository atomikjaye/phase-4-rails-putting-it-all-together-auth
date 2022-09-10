class RecipesController < ApplicationController
  before_action :authorize
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def index
    render json: Recipe.all
  end

  def create
    recipe = User.find_by(id: session[:user_id])
    newRecipe = recipe.recipes.create!(recipe_params)
    render json: newRecipe, status: :created
  end

  private
  def recipe_params
    params.permit(:title, :instructions, :minutes_to_complete)
  end

  def authorize
    return render json: { errors: ["Not authorized"] }, status: :unauthorized unless session.include? :user_id
  end

  def render_unprocessable_entity_response(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end
end
