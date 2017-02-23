class LookupTest < ActiveSupport::TestCase
  test '#save validates username presence' do
    lookup = Lookup.new username: nil
    refute lookup.save
    assert_includes lookup.errors[:username], "can't be blank"
  end
end
