class GithubServiceTest < ActiveSupport::TestCase
  def setup
    @service = GithubService.new user: 'heidar'
  end

  test '#favorite_language' do
    assert_equal 'Ruby', @service.favorite_language
  end
end