require 'test_helper'

class LookupFlowTest < Capybara::Rails::TestCase
  test 'lookup' do
    visit root_path
    fill_in 'Enter a GitHub Username', with: 'heidar'
    click_on 'Lookup'

    assert page.has_content?('Ruby')
  end

  test 'lookup validation only fired on submit' do
    visit root_path

    refute page.has_content?("Username can't be blank")
  end

  test 'lookup validation' do
    visit root_path
    click_on 'Lookup'

    assert page.has_content?("Username can't be blank")
  end

  test 'lookup non-existent user' do
    visit root_path
    fill_in 'Enter a GitHub Username', with: 'kjsadhfksadjhfdkasjf'
    click_on 'Lookup'

    assert page.has_content?('User not found')
  end

  test 'lookup user with no public repos' do
    visit root_path
    fill_in 'Enter a GitHub Username', with: 'johnc'
    click_on 'Lookup'

    assert page.has_content?('User has no repositories listed')
  end
end
