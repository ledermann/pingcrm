require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include Devise::Test::IntegrationHelpers

  driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400] do |driver_option|
    driver_option.add_argument('--disable-ipc-flooding-protection')
  end

  teardown do
    messages = page.driver.browser.logs.get(:browser).map do |log|
      "[#{log.level}] #{log.message}"
    end

    assert_empty(messages)
  end
end
