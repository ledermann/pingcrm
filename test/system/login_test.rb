require 'application_system_test_case'

class LoginTest < ApplicationSystemTestCase
  setup do
    @account = create(:account)
    @user = create(:user, account: @account, owner: true)
  end

  test 'Login with valid credentials will be successful' do
    visit '/login'
    assert_selector 'h1', text: 'Welcome Back!'

    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_on 'Login'

    # Wait for the login form to disappear (indicating successful login)
    assert_no_selector 'h1', text: 'Welcome Back!'

    # Now check for the content on the dashboard
    assert_selector 'div', text: 'Hey there!'

    click_on 'John Doe'
    click_on 'Logout'

    # Wait for dashboard to disappear and login page to appear
    assert_no_selector 'div', text: 'Hey there!'
    assert_selector 'div', text: 'Welcome Back!'
  end

  test 'Login with invalid credentials will fail' do
    visit '/login'

    fill_in 'Email', with: @user.email
    fill_in 'Password', with: 'invalid'
    click_on 'Login'

    assert_selector 'div', text: I18n.t('devise.failure.invalid')
  end

  test 'Redirect to login for Inertia requests, too' do
    sign_in @user
    visit '/organizations'

    # Signout user, e.g. in a second browser window
    sign_out @user

    # Click a link that requires authentication
    click_on 'Contacts'

    assert_current_path('/login')
  end
end
