require 'application_system_test_case'

class ContactsTest < ApplicationSystemTestCase
  setup do
    @account = create(:account)
    @user = create(:user, account: @account, owner: true)
  end

  test 'list all contacts and allows to paginate and search' do
    sign_in @user

    contacts = create_list(:contact, 15, account: @account).sort_by(&:name)

    visit '/contacts'

    assert_selector 'h1', text: 'Contacts'
    assert_selector 'table tbody tr', count: 10
    contacts
      .first(10)
      .each { |contact| assert_selector 'table', text: contact.last_name }

    click_link 'Next'
    assert_selector 'table tbody tr', count: 5
    contacts
      .last(5)
      .each { |contact| assert_selector 'table', text: contact.last_name }

    contacts.first.update! last_name: 'AAA'
    fill_in 'search', with: 'AAA'

    assert_selector 'h1', text: 'Contacts'
    assert_selector 'table tbody tr', count: 1
    assert_selector 'table', text: 'AAA'
  end

  test 'cannot view deleted contacts by default, but allows to change filter' do
    sign_in @user
    contacts = create_list(:contact, 5, account: @account)
    contacts.first.soft_delete!

    visit '/contacts'

    assert_selector 'h1', text: 'Contacts'
    assert_selector 'table tbody tr', count: 4

    click_button 'Filter'
    select 'With Trashed', from: 'Trashed:'

    assert_selector 'h1', text: 'Contacts'
    assert_selector 'table tbody tr', count: 5
  end

  test 'can add contact' do
    sign_in @user

    visit '/contacts'
    click_link 'Create Contact'

    assert_selector 'form'
    assert_selector 'button', text: 'Create Contact'

    fill_in 'First name:', with: 'Jane'
    fill_in 'Last name:', with: 'Doe'
    click_button 'Create Contact'
    assert_selector 'div', text: 'Contact created.'
  end

  test 'can edit contact' do
    sign_in @user
    contact = create(:contact, account: @account)

    visit "/contacts/#{contact.id}/edit"

    assert_selector 'form'
    assert_selector 'button', text: 'Update Contact'
    fill_in 'First name:', with: 'Jane'
    fill_in 'Last name:', with: 'Doe'
    click_button 'Update Contact'

    assert_selector 'div', text: 'Contact updated.'
  end

  test 'can delete an contact' do
    sign_in @user
    contact = create(:contact, account: @account)

    visit "/contacts/#{contact.id}/edit"

    assert_selector 'button', text: 'Delete Contact'
    accept_confirm { click_button 'Delete Contact' }

    assert_selector 'div', text: 'Contact deleted.'
  end

  test 'cannot do anything without login' do
    visit '/contacts'

    assert_selector 'div', text: 'Welcome Back!'
  end
end
