class Lookup < ActiveType::Object
  attribute :username, :string

  validates :username, presence: true

  def favorite_language
    GithubService.new(username: username).favorite_language
  end
end
