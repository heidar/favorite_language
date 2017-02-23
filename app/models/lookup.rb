# Virtual model for favorite language lookups.
class Lookup < ActiveType::Object
  attribute :username, :string

  validates :username, presence: true

  # The result of the lookup. It will be a string which contains the
  # programming language which was most common in the user's repositories.
  # If an error occurred or the user did not exist, the result will be the
  # error message.
  def result
    GithubService.new(username: username).favorite_language
  rescue StandardError => exception
    exception.message
  end
end
