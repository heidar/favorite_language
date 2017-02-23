require 'test_helper'

class GithubServiceTest < ActiveSupport::TestCase
  test '#favorite_language' do
    service = GithubService.new username: 'heidar'
    assert_equal 'Ruby', service.favorite_language
  end

  test '#favorite_language non-existent user' do
    service = GithubService.new username: 'kjsadhfksadjhfdkasjf'
    assert_raise GithubService::NotFound do
      service.favorite_language
    end
  end

  test '#favorite_language user with no repos' do
    service = GithubService.new username: 'johnc'
    assert_raise GithubService::NoRepositories do
      service.favorite_language
    end
  end
end
