class GithubService
  class << self
    @@client = Octokit::Client.new
  end

  def initialize(user:)
    @user = user
  end

  def favorite_language

  end

  private

  def repositories
    @@client.user(@user).rels[:repos].get.data
  end
end
