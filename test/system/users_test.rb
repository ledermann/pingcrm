require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @account = create(:account)
    @user = create(:user, account: @account, owner: true)
  end

  test 'list all users and allows to search' do
    sign_in @user
    users = Array.new(15) { create(:user, account: @account) }.sort_by(&:name)

    visit '/users'

    assert_selector 'h1', text: 'Users'
    assert_selector 'table tbody tr', count: 15 + 1
    users.each do |user|
      assert_selector 'table', text: user.name
    end

    users.first.update! last_name: 'Turing'
    fill_in 'search', with: 'Turing'

    assert_selector 'h1', text: 'Users'
    assert_selector 'table tbody tr', count: 1
    assert_selector 'table', text: users.first.name
  end

  test 'edits a user' do
    sign_in @user

    visit "/users/#{@user.id}/edit"

    assert_selector 'form'
    fill_in 'First name:', with: 'Jonathan'
    click_on 'Update User'

    assert_selector 'div', text: 'User updated.'
  end

  test 'deletes a user' do
    other_user = create(:user, account: @account)
    sign_in @user

    visit "/users/#{other_user.id}/edit"

    accept_confirm do
      click_on 'Delete User'
    end

    assert_selector 'div', text: 'User deleted.'
  end

  test 'cannot view deleted users by default, but allows to change filter' do
    sign_in @user
    users = Array.new(5) { create(:user, account: @account) }
    users.first.soft_delete!

    visit '/users'

    assert_selector 'h1', text: 'Users'
    assert_selector 'table tbody tr', count: 4 + 1

    click_on 'Filter'
    select 'With Trashed', from: 'Trashed:'
    select 'User', from: 'Role:'

    assert_selector 'h1', text: 'Users'
    assert_selector 'table tbody tr', count: 5
  end

  test 'cannot do anything without login' do
    visit '/users'

    assert_selector 'div', text: 'You need to sign in or sign up before continuing.'
  end
end
