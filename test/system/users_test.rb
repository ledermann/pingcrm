require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @account = create(:account)
    @owner = create(:user, account: @account, owner: true)
    @user = create(:user, account: @account, owner: false)
  end

  test 'list all users and allows to search' do
    sign_in @user
    users = Array.new(15) { create(:user, account: @account) }.sort_by(&:name)

    visit '/users'

    assert_selector 'h1', text: 'Users'
    assert_selector 'table tbody tr', count: 15 + 2
    users.each do |user|
      assert_selector 'table', text: user.name
    end

    users.first.update! last_name: 'Turing'
    fill_in 'search', with: 'Turing'

    assert_selector 'h1', text: 'Users'
    assert_selector 'table tbody tr', count: 1
    assert_selector 'table', text: users.first.name
  end

  test 'Owner can add user' do
    sign_in @owner

    visit "/users"
    click_on 'Create User'

    assert_selector 'form'
    assert true, find_field('Owner:').value

    assert_selector 'button', text: 'Create User'
    fill_in 'First name:', with: 'Jonathan'
    fill_in 'Last name:', with: 'Smith'
    fill_in 'Email:', with: 'john@smith.com'
    click_on 'Create User'
    assert_selector 'div', text: 'User created.'
  end

  test 'Non-owner cannot add user' do
    sign_in @user

    visit "/users"
    assert_no_selector 'button', text: 'Create User'

    visit "/users/new"
    assert_selector 'div', text: 'Forbidden'
  end

  test 'Owner can edit user' do
    sign_in @owner

    visit "/users/#{@user.id}/edit"

    assert_selector 'form'
    assert_selector 'button', text: 'Update User'
    fill_in 'First name:', with: 'Jonathan'
    click_on 'Update User'

    assert_selector 'div', text: 'User updated.'
  end

  test 'Non-owner cannot edit user' do
    sign_in @user

    visit "/users/#{@user.id}/edit"

    assert_selector 'form'
    assert_no_selector 'button', text: 'Update User'
  end

  test 'Owner can delete a user' do
    sign_in @owner

    visit "/users/#{@user.id}/edit"

    assert_selector 'button', text: 'Delete User'
    accept_confirm do
      click_on 'Delete User'
    end

    assert_selector 'div', text: 'User deleted.'
  end

  test 'Non-owner cannot delete a user' do
    sign_in @user

    visit "/users/#{@user.id}/edit"

    assert_no_selector 'button', text: 'Delete User'
  end

  test 'cannot view deleted users by default, but allows to change filter' do
    sign_in @owner
    @user.soft_delete!

    visit '/users'

    assert_selector 'h1', text: 'Users'
    assert_no_selector 'table tbody tr', text: @user.email

    click_on 'Filter'
    select 'With Trashed', from: 'Trashed:'
    select 'User', from: 'Role:'

    assert_selector 'table tbody tr', text: @user.email
  end

  test 'cannot do anything without login' do
    visit '/users'

    assert_selector 'div', text: 'Welcome Back!'
  end
end
