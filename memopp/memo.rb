require 'sinatra'
require 'sinatra/reloader'
require 'erb'
require 'json'

before do
  @total = 1
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
  @articles << {"id" => @total, "article" => params[:article]}
  File.open("articles.json", "a") do |f|
    JSON.dump(@articles, f)
  end
  @total += 1
  erb :result
end