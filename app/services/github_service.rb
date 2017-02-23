class GithubService
  class NotFound < StandardError
    def initialize(msg = 'User not found')
      super
    end
  end

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
    results = repositories.reduce(Hash.new(0)) do |result, repository|
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
