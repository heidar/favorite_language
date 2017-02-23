require 'test_helper'

class GithubServiceTest < ActiveSupport::TestCase
  def setup
    @service = GithubService.new username: 'heidar'
  end

  test '#favorite_language' do
    assert_equal 'Ruby', @service.favorite_language
  end
end
