class LookupTest < ActiveSupport::TestCase
  test '#save validates username presence' do
    lookup = Lookup.new username: nil
    refute lookup.save
    assert_includes lookup.errors[:username], "can't be blank"
  end

  test '#favorite_language' do
    lookup = Lookup.new username: 'heidar'
    assert_equal 'Ruby', lookup.result
  end

  test '#favorite_language error handling' do
    lookup = Lookup.new username: 'johnc'
    assert_equal 'User has no repositories listed', lookup.result
  end
end
