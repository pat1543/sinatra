require 'sinatra'
require 'sinatra/reloader'
require 'erb'
require 'json'

before do
  @user = "テストユーザー"
  @articles = {}
  File.open("articles.json") do |file|
    @articles = JSON.load(file)
  end
end

get '/' do
  erb :index
end

get '/show/:id' do
  @detail = @articles[params[:id]] - 1
  erb :show
end

get '/new' do
  erb :new
end

post '/new' do
  @new_id = @articles.length
  @articles[:id] << @new_id
  @articles["article"] = params[:article]
  File.open("articles.json", "w") do |f|
    JSON.dump(@articles, f)
  end
  erb :result
end