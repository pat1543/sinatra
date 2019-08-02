# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'erb'
require 'json'
require 'securerandom'

before do
  File.open('articles.json') do |file|
    @articles = JSON.load(file)
  end
end

get '/' do
  erb :index
end

get '/show/:id' do
  @id = @articles['memos'].find { |x| x['id'] == params[:id] }['id']
  @title = @articles['memos'].find { |x| x['id'] == params[:id] }['title']
  @article = @articles['memos'].find { |x| x['id'] == params[:id] }['article']
  erb :show
end

get '/new' do
  erb :new
end

get '/edit/:id' do
  @id = @articles['memos'].find { |x| x['id'] == params[:id] }['id']
  @title = @articles['memos'].find { |x| x['id'] == params[:id] }['title']
  @article = @articles['memos'].find { |x| x['id'] == params[:id] }['article']
  erb :edit
end

patch '/edit/:id' do
  @articles['memos'].find { |x| x['id'] == params[:id] }['title'] = params[:title]
  @articles['memos'].find { |x| x['id'] == params[:id] }['article'] = params[:article]
  File.open('articles.json', 'w') do |f|
    JSON.dump({ 'memos' => @articles['memos'] }, f)
  end
  erb :result
end

delete '/edit/:id' do
  hash = @articles['memos'].find { |x| x['id'] == params[:id] }
  @index = @articles['memos'].index(hash)
  @articles['memos'].delete_at(@index)
  File.open('articles.json', 'w') do |f|
    JSON.dump({ 'memos' => @articles['memos'] }, f)
  end
  erb :delete_result
end

class Create
  attr_accessor :id, :title, :article

  def initialize(title, article)
    @id = SecureRandom.uuid
    @title = title
    @article = article
  end
end

post '/new' do
  @memo = Create.new(params[:title], params[:article])
  @articles['memos'] << { id: @memo.id, title: @memo.title, article: @memo.article }
  File.open('articles.json', 'w') do |f|
    JSON.dump({ 'memos' => @articles['memos'] }, f)
  end
  erb :result
end
