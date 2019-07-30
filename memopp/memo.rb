require 'sinatra'
require 'sinatra/reloader'
require 'erb'
require 'json'
require 'securerandom'

before do
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
  @post = @articles["memos"].find{|x| x["id"] == params[:id]}["article"]
  erb :show
end

get '/new' do
  erb :new
end

class Create
  attr_reader :id, :article, :body

  def initialize(title, article)
    @id = SecureRandom.uuid
    @title = title
    @article = article

  end

end

  post '/new' do
    @memo = Create.new(params[:title], params[:article])
    @articles["memos"] << {id: @memo.id, article: @memo.article}
    File.open("articles.json", "w") do |f|
      JSON.dump({"memos" => @articles["memos"]}, f)
    end
    erb :result
  end
