require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include Devise::Test::IntegrationHelpers

  Capybara.default_max_wait_time = 5

  driven_by :selenium,
            using: :headless_chrome,
            screen_size: [1400, 1400] do |driver_option|
    driver_option.add_argument('--disable-ipc-flooding-protection')

    # Chrome 120 compatibility
    driver_option.add_argument '--headless=new'
  end

  teardown do
    messages =
      page
        .driver
        .browser
        .logs
        .get(:browser)
        .map { |log| "[#{log.level}] #{log.message}" }

    assert_empty(messages)
  end
end
