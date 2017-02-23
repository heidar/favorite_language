class Lookup < ActiveType::Object
  attribute :username, :string

  validates :username, presence: true

  def result
    GithubService.new(username: username).favorite_language
  rescue StandardError => exception
    exception.message
  end
end
