# Service to abstract Octokit and do the caluclations for determining the
# favorite language of a GitHub user.
class GithubService
  # Provide a nicer error message than the one Octokit gives us.
  class NotFound < StandardError
    def initialize(msg = 'User not found')
      super
    end
  end

  # Not all users will have public repositories.
  class NoRepositories < StandardError
    def initialize(msg = 'User has no repositories listed')
      super
    end
  end

  def initialize(username:)
    @client     = Octokit::Client.new
    @username   = username
  end

  def favorite_language
    # Here we do a simple reducer to tally up the times each language is the
    # most used one in a repository. The result of this is a hash for each
    # language, where the language is the key and the value is the number of
    # times it is used. E.g. { "Ruby" => 3 }
    results = repositories.reduce(Hash.new(0)) do |result, repository|
      next result unless repository.language

      result.update repository.language => result[repository.language] + 1
    end

    results.max_by { |_, value| value }.first
  end

  private

  def repositories
    @repositories ||= @client.user(@username).rels[:repos].get.data
    raise GithubService::NoRepositories unless @repositories.present?
    @repositories
  rescue Octokit::NotFound
    raise GithubService::NotFound
  end
end
