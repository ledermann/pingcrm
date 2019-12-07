require "application_system_test_case"

class ContactsTest < ApplicationSystemTestCase
  setup do
    @account = create(:account)
    @user = create(:user, account: @account, owner: true)
  end

  test 'list all contacts and allows to paginate and search' do
    sign_in @user

    contacts = Array.new(15) { create(:contact, account: @account) }.sort_by(&:name)

    visit '/contacts'

    assert_selector 'h1', text: 'Contacts'
    assert_selector 'table tbody tr', count: 10
    contacts.first(10).each do |contact|
      assert_selector 'table', text: contact.last_name
    end

    click_on 'Next'
    assert_selector 'table tbody tr', count: 5
    contacts.last(5).each do |contact|
      assert_selector 'table', text: contact.last_name
    end

    contacts.first.update! last_name: 'AAA'
    fill_in 'search', with: 'AAA'

    assert_selector 'h1', text: 'Contacts'
    assert_selector 'table tbody tr', count: 1
    assert_selector 'table', text: 'AAA'
  end

  test 'cannot view deleted contacts by default, but allows to change filter' do
    sign_in @user
    contacts = Array.new(5) { create(:contact, account: @account) }
    contacts.first.soft_delete!

    visit '/contacts'

    assert_selector 'h1', text: 'Contacts'
    assert_selector 'table tbody tr', count: 4

    click_on 'Filter'
    select 'With Trashed', from: 'Trashed:'

    assert_selector 'h1', text: 'Contacts'
    assert_selector 'table tbody tr', count: 5
  end

  test 'cannot do anything without login' do
    visit '/contacts'

    assert_selector 'div', text: 'You need to sign in before continuing.'
  end
end
