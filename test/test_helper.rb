ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'capybara/rails'

Capybara.server = :puma, { Silent: true } # To clean up your test output

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  include FactoryBot::Syntax::Methods

  teardown do
    messages = page.driver.browser.logs.get(:browser).map do |log|
      "[#{log.level}] #{log.message}"
    end

    assert_empty(messages)
  end

  # Add more helper methods to be used by all tests here...
end
