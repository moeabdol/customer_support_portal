require 'rails_helper'

describe 'create ticket' do
  let(:ticket) { build(:ticket) }
  before(:example) do
    visit tickets_path
    click_on 'create-new-ticket-button'
  end

  it 'succeeds with valid attributes' do
    fill_in 'ticket_content', with: 'Hello World'
    click_on 'new-ticket-button'
    expect(page).to have_selector('p', text: 'Hello World')
  end

  it 'fails with invalid attributes' do
    fill_in 'ticket_content', with: nil
    click_on 'new-ticket-button'
    expect(page).to have_selector('.help-block', text: "can't be blank")
  end
end

describe 'edit ticket' do
  let!(:ticket) { create(:ticket) }
  before(:example) do
    visit tickets_path
    click_on "ticket-#{ticket.id}"
    click_on 'edit-ticket-button'
  end

  it 'succeeds with valid attributes' do
    fill_in 'ticket_content', with: 'Hello World'
    click_on 'edit-ticket-button'
    expect(page).to have_selector('p', text: 'Hello World')
  end

  it 'fails with invalid attributes' do
    fill_in 'ticket_content', with: nil
    click_on 'edit-ticket-button'
    expect(page).to have_selector('.help-block', text: "can't be blank")
  end
end

describe 'delete ticket', js: true do
  it 'succeeds' do
    ticket = create(:ticket)
    visit tickets_path
    click_on "ticket-#{ticket.id}"
    click_on 'delete-ticket-button'
    page.evaluate_script('window.confirm = function() { return true; }')
    expect(current_path).to eq(tickets_path)
    expect(page).not_to have_selector('div', id: "ticket-#{ticket.id}")
  end
end
