class Memo
  attr_accessor :id, :title, :article

  def initialize(title, article)
    @id = SecureRandom.uuid
    @title = title
    @article = article
  end
end