require "application_system_test_case"

class OrganizationsTest < ApplicationSystemTestCase
  setup do
    @account = create(:account)
    @user = create(:user, account: @account, owner: true)
  end

  test 'list all organizations and allows to paginate and search' do
    sign_in @user
    organizations = Array.new(15) { create(:organization, account: @account) }.sort_by(&:name)

    visit '/organizations'

    assert_selector 'h1', text: 'Organizations'
    assert_selector 'table tbody tr', count: 10
    organizations.first(10).each do |organization|
      assert_selector 'table', text: organization.name
    end

    click_on 'Next'
    assert_selector 'table tbody tr', count: 5
    organizations.last(5).each do |organization|
      assert_selector 'table', text: organization.name
    end

    organizations.first.update! name: 'Some Big Fancy Company Name'
    fill_in 'search', with: 'Some Big Fancy Company Name'

    assert_selector 'h1', text: 'Organizations'
    assert_selector 'table tbody tr', count: 1
    assert_selector 'table', text: organizations.first.name
  end

  test 'cannot view deleted organizations by default, but allows to change filter' do
    sign_in @user
    organizations = Array.new(5) { create(:organization, account: @account) }
    organizations.first.soft_delete!

    visit '/organizations'

    assert_selector 'h1', text: 'Organizations'
    assert_selector 'table tbody tr', count: 4

    click_on 'Filter'
    select 'With Trashed', from: 'Trashed:'

    assert_selector 'h1', text: 'Organizations'
    assert_selector 'table tbody tr', count: 5
  end

  test 'cannot do anything without login' do
    visit '/organizations'

    assert_selector 'div', text: 'You need to sign in or sign up before continuing.'
  end
end
