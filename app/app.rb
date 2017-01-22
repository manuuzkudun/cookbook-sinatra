require "sinatra"
require "sinatra/reloader" if development?
#require "pry-byebug"
require "better_errors"

require_relative 'controller'
require_relative 'cookbook'

set :bind, '0.0.0.0'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

csv_file   = File.join('./data/recipes.csv')
cookbook   = Cookbook.new(csv_file)
controller = Controller.new(cookbook)

get '/' do
  @recipe_list = controller.list
  erb :index
end

get '/list' do
  erb :list
end

get '/team/:username' do
  puts params[:username]
  "The username is #{params[:username]}"
end
