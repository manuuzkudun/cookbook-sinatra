require 'csv'
require_relative 'recipe'

class Cookbook
  def initialize(csv_file)
    @csv_file = csv_file
    @recipe_list = get_recipes_from_file(csv_file)
  end

  def add_recipe(recipe)
    all << recipe
    update_db
  end

  def remove_recipe(recipe_id)
    all.delete_at(recipe_id)
    update_db
  end

  def all
    @recipe_list
  end

  private

  def update_db
    write_recipes_to_file(data_file, all)
  end

  def data_file
    @csv_file
  end

  def get_recipes_from_file(csv_file)
    out = []
    CSV.foreach(csv_file) { |row| out << Recipe.new(row[0], row[1]) }
    out
  end

  def write_recipes_to_file(csv_file, recipes)
    CSV.open(csv_file, 'w') do |csv_object|
      recipes.each { |recipe| csv_object << [recipe.name, recipe.description] }
    end
  end
end
