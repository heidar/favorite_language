ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/autorun'
require 'minitest/rails/capybara'
require 'vcr'
require 'webmock'

VCR.configure do |config|
  config.cassette_library_dir = 'test/cassettes'
  config.hook_into :webmock
end

module ActiveSupport
  class TestCase
    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical
    # order.
    fixtures :all

    # Add more helper methods to be used by all tests here...

    # Monkey patch to automate VCR.
    def self.test(test_name, &block)
      return super if block.nil?

      cassette = [name, test_name].map do |str|
        str.underscore.gsub(/[^A-Z]+/i, '_')
      end.join('/')

      super(test_name) do
        VCR.use_cassette(cassette) do
          instance_eval(&block)
        end
      end
    end
  end
end
