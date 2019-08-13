# frozen_string_literal: true

class Article
  attr_accessor :id, :title, :article
  def initialize(title, article)
    @id = SecureRandom.uuid
    @title = title
    @article = article
  end

  def self.find_memos
    File.open("articles.json") do |file|
      @articles = JSON.load(file)
    end
  end

  def self.find_title(article, id)
    article["memos"].find { |x| x["id"] == id }["title"]
  end

  def self.find_article(article, id)
    article["memos"].find { |x| x["id"] == id }["article"]
  end

  def self.write(articles)
    File.open("articles.json", "w") do |f|
      JSON.dump({ "memos" => articles["memos"] }, f)
    end
  end

  def self.update(articles, id, title, article)
    articles["memos"].find { |x| x["id"] == id }["title"] = title
    articles["memos"].find { |x| x["id"] == id }["article"] = article
  end

  def self.delete(articles, id)
    hash = articles["memos"].find { |x| x["id"] == id }
    index = articles["memos"].index(hash)
    articles["memos"].delete_at(index)
  end
end
