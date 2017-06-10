require 'rails_helper'

feature 'create ticket' do
  let(:ticket) { build(:ticket) }
  let!(:customer) { create(:customer) }
  before(:example) do
    signin(customer)
    visit user_path(customer)
    click_on 'create-new-ticket-button'
  end

  scenario 'customer can create ticket with valid attributes' do
    fill_in 'ticket_content', with: 'Hello World'
    click_on 'new-ticket-button'
    expect(page).to have_selector('p', text: 'Hello World')
  end

  scenario 'customer cannot create ticket with invalid attributes' do
    fill_in 'ticket_content', with: nil
    click_on 'new-ticket-button'
    expect(page).to have_selector('.help-block', text: "can't be blank")
  end
end

feature 'view tickets', js: true do
  scenario 'agent can view all tickets' do
    agent = create(:agent)
    ticket1 = create(:ticket, content: 'first ticket.')
    ticket2 = create(:ticket, content: 'second ticket.')
    signin(agent)
    visit tickets_path
    expect(page).to have_selector('td', text: ticket1.content)
    expect(page).to have_selector('td', text: ticket2.content)
  end

  scenario 'admin can view all tickets' do
    admin = create(:admin)
    ticket1 = create(:ticket, content: 'first ticket.')
    ticket2 = create(:ticket, content: 'second ticket.')
    signin(admin)
    visit tickets_path
    expect(page).to have_selector('td', text: ticket1.content)
    expect(page).to have_selector('td', text: ticket2.content)
  end
end

feature 'edit ticket', js: true do
  context 'customer' do
    let!(:ticket) { create(:ticket) }
    let!(:customer) { create(:customer) }
    before(:example) do
      customer.tickets << ticket
      signin(customer)
      visit ticket_path(ticket)
      click_on 'edit-ticket-button'
    end

    scenario 'can edit his ticket with valid attributes' do
      fill_in 'ticket_content', with: 'Hello World'
      click_on 'update-ticket-button'
      expect(page).to have_selector('p', text: 'Hello World')
    end

    scenario 'cannot edit ticket with invalid attributes' do
      fill_in 'ticket_content', with: nil
      click_on 'update-ticket-button'
      expect(page).to have_selector('.help-block', text: "can't be blank")
    end
  end

  context 'admin' do
    let!(:ticket) { create(:ticket) }
    let!(:customer) { create(:customer) }
    let!(:admin) { create(:admin) }
    before(:example) do
      customer.tickets << ticket
      signin(admin)
      visit ticket_path(ticket)
      click_on 'edit-ticket-button'
    end

    scenario 'can edit ticket with valid attributes' do
      fill_in 'ticket_content', with: 'Hello World'
      click_on 'update-ticket-button'
      expect(page).to have_selector('p', text: 'Hello World')
    end

    scenario 'cannot edit ticket with invalid attributes' do
      fill_in 'ticket_content', with: nil
      click_on 'update-ticket-button'
      expect(page).to have_selector('.help-block', text: "can't be blank")
    end
  end
end

feature 'delete ticket', js: true do
  it 'custmoer can delete his own ticket' do
    customer = create(:customer)
    ticket = create(:ticket)
    customer.tickets << ticket
    signin(customer)
    visit ticket_path(ticket)
    click_on 'delete-ticket-button'
    page.evaluate_script('window.confirm = function() { return true; }')
    expect(current_path).to eq(tickets_path)
    expect(page).not_to have_selector('div', id: "ticket-#{ticket.id}")
  end
end

feature 'resolve ticket' do
  it 'agent can resolve tickets' do
    ticket = create(:ticket, status: 'unresolved')
    customer = create(:customer)
    customer.tickets << ticket
    signin(create(:agent))
    visit ticket_path(ticket)
    click_on 'resolve-ticket-button'
    expect(current_path).to eq(ticket_path(ticket))
    expect(page).to have_selector('p', text: 'resolved')
    expect(page).not_to have_selector('p', text: 'unresolved')
  end
end
