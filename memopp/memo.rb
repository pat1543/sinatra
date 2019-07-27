require 'sinatra'
require 'sinatra/reloader'
require 'erb'

before do
  @user = "テストユーザー"
end

get '/' do
  @article = params[:article]
  erb :index
end

get '/new' do
  File.open("articles.txt", "r") do |f|
    @articles = f.read.split("\n")
  end
  erb :form
end

post '/new' do
  @article = params[:article]
  File.open("articles.txt", "a") do |f|
    f.puts(@article)
  end
  erb :result
end

