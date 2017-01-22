require_relative 'recipe'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
  end

  def list
    recipe_list.all
  end

  def create
    name = @view.ask_user_for_recipe_name
    description = @view.ask_user_for_recipe_description

    recipe = Recipe.new(name, description)
    recipe_list.add_recipe(recipe)
  end

  def destroy
    list
    recipe_id = @view.ask_user_for_recipe_id
    recipe_list.remove_recipe(recipe_id)
  end

  private

  def recipe_list
    @cookbook
  end
end
