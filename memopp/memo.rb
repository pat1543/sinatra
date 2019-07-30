require 'sinatra'
require 'sinatra/reloader'
require 'erb'
require 'json'
require 'securerandom'

before do
  @total = 0
  @article = []
  @articles = {}
  File.open("articles.json") do |file|
    @articles = JSON.load(file)
  end
end

get '/' do
  File.open("articles.json") do |file|
    @articles = JSON.load(file)
  end
  erb :index
end

get '/show/:id' do
  @post = @articles["memos"].index(params[:id])

  erb :show
end

get '/new' do
  erb :new
end

class Create
  attr_reader :id, :article, :body

  def initialize(article)
    @id = SecureRandom.uuid
    @article = article
    @body = []
  end

end


  post '/new' do
    @memo = Create.new(params[:article])
    @articles["memos"] << {id: @memo.id, article: @memo.article}
    File.open("articles.json", "w") do |f|
      JSON.dump({"memos" => @articles["memos"]}, f)
    end
    erb :result
  end