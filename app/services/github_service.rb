class GithubService
  def initialize(user:)
    @client = Octokit::Client.new
    @user   = user
  end

  def favorite_language
    results = repositories.reduce(Hash.new(0)) do |result, repository|
      result.update repository.language => result[repository.language] + 1
    end

    results.max_by { |_, value| value }.first
  end

  private

  def repositories
    @client.user(@user).rels[:repos].get.data
  end
end
