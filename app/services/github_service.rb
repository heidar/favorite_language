class GithubService
  def initialize(username:)
    @client     = Octokit::Client.new
    @username   = username
  end

  def favorite_language
    results = repositories.reduce(Hash.new(0)) do |result, repository|
      result.update repository.language => result[repository.language] + 1
    end

    results.max_by { |_, value| value }.first
  end

  private

  def repositories
    @client.user(@username).rels[:repos].get.data
  end
end
