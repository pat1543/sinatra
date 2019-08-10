# frozen_string_literal: true

require "sinatra"
require "sinatra/reloader"
require "erb"
require "json"
require "securerandom"
require "./article"

before do
  @articles = Article.get_memos
end

get "/" do
  erb :index
end

get "/show/:id" do
  @id = params[:id]
  @title = Article.find_title(@articles, params[:id])
  @article = Article.find_article(@articles, params[:id])
  erb :show
end

get "/new" do
  erb :new
end

get "/edit/:id" do
  @id = params[:id]
  @title = Article.find_title(@articles, params[:id])
  @article = Article.find_article(@articles, params[:id])
  erb :edit
end

patch "/edit/:id" do
  Article.update(@articles, params[:id], params[:title], params[:article])
  Article.write(@articles)
  erb :result
end

delete "/edit/:id" do
  Article.delete(@articles, params[:id])
  Article.write(@articles)
  erb :delete_result
end

post "/new" do
  article = Article.new(params[:title], params[:article])
  @articles["memos"] << { id: article.id, title: article.title, article: article.article }
  Article.write(@articles)
  erb :result
end
