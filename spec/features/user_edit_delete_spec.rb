require 'rails_helper'

feature 'edit user' do
  let(:admin) { create(:user, role: 'admin') }
  let(:agent) { create(:user, role: 'agent') }
  let(:customer) { create(:user, role: 'customer') }
  before(:example) { signin(admin) }

  scenario 'admin can edit agent email' do
    visit user_path(agent)
    click_on 'edit-user-button'
    fill_in 'user_email', with: 'agent@example.com'
    click_on 'edit-user-button'
    expect(page).to have_selector('.alert', text: 'User updated successfully.')
  end

  scenario 'admin can edit customer email' do
    visit user_path(customer)
    click_on 'edit-user-button'
    fill_in 'user_email', with: 'customer@example.com'
    click_on 'edit-user-button'
    expect(page).to have_selector('.alert', text: 'User updated successfully.')
  end

  scenario 'admin can change a customer to an agent' do
    visit user_path(customer)
    click_on 'edit-user-button'
    select 'agent', from: 'user_role'
    click_on 'edit-user-button'
    expect(page).to have_selector('.alert', text: 'User updated successfully.')
  end
end

feature 'delete user' do
  let(:admin) { create(:user, role: 'admin') }
  let(:agent) { create(:user, role: 'agent') }
  let(:customer) { create(:user, role: 'customer') }
  before(:example) { signin(admin) }

  scenario 'admin can delete customer' do
    visit user_path(customer)
    click_on 'delete-user-button'
    expect(current_path).to eq(users_path)
    expect(page).to have_selector('.alert', text: 'User deleted successfully.')
  end

  scenario 'admin can delete agent' do
    visit user_path(agent)
    click_on 'delete-user-button'
    expect(current_path).to eq(users_path)
    expect(page).to have_selector('.alert', text: 'User deleted successfully.')
  end

  scenario 'when customer is deleted then all associated tickets are deleted' do
    ticket1 = create(:ticket, content: 'first ticket.')
    ticket2 = create(:ticket, content: 'second ticket.')
    customer.tickets << ticket1
    customer.tickets << ticket2
    visit user_path(customer)
    click_on 'delete-user-button'
    visit tickets_path
    expect(page).not_to have_selector('tr', text: 'first ticket.')
    expect(page).not_to have_selector('tr', text: 'second ticket.')
  end

  scenario 'when agent is deleted then all associated tickets are deleted' do
    ticket1 = create(:ticket, content: 'first ticket.')
    ticket2 = create(:ticket, content: 'second ticket.')
    agent.tickets << ticket1
    agent.tickets << ticket2
    visit user_path(agent)
    click_on 'delete-user-button'
    visit tickets_path
    expect(page).not_to have_selector('tr', text: 'first ticket.')
    expect(page).not_to have_selector('tr', text: 'second ticket.')
  end
end
