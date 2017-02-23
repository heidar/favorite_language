require 'test_helper'

class LookupFlowTest < Capybara::Rails::TestCase
  test 'lookup' do
    perform_lookup username: 'heidar'
    assert page.has_content?('Ruby')
  end

  test 'lookup validation only fired on submit' do
    visit root_path
    refute page.has_content?("Username can't be blank")
  end

  test 'lookup validation' do
    perform_lookup username: nil
    assert page.has_content?("Username can't be blank")
  end

  test 'lookup non-existent user' do
    perform_lookup username: 'kjsadhfksadjhfdkasjf'
    assert page.has_content?('User not found')
  end

  test 'lookup user with no public repos' do
    perform_lookup username: 'johnc'
    assert page.has_content?('User has no repositories listed')
  end

  private

  def perform_lookup(username:)
    visit root_path
    fill_in 'Enter a GitHub Username', with: username
    click_on 'Lookup'
  end
end
