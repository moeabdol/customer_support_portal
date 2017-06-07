require 'rails_helper'

feature 'header links visibility' do
  scenario 'customer cannot see users link' do
    signin(create(:user, role: 'customer'))
    expect(page).not_to have_selector('li', text: 'Users')
  end

  scenario 'customer cannot see agent link' do
    signin(create(:user, role: 'customer'))
    expect(page).not_to have_selector('li', text: 'Agents')
  end

  scenario 'customer cannot see customers link' do
    signin(create(:user, role: 'customer'))
    expect(page).not_to have_selector('li', text: 'Customers')
  end

  scenario 'agent cannot see users link' do
    signin(create(:user, role: 'agent'))
    expect(page).not_to have_selector('li', text: 'Users')
  end

  scenario 'agent cannot see agents link' do
    signin(create(:user, role: 'agent'))
    expect(page).not_to have_selector('li', text: 'Agents')
  end

  scenario 'agent can see customers link' do
    signin(create(:user, role: 'agent'))
    expect(page).to have_selector('li', text: 'Customers')
  end

  scenario 'admin can see users link' do
    signin(create(:user, role: 'admin'))
    expect(page).to have_selector('li', text: 'Users')
  end

  scenario 'admin can see agents link' do
    signin(create(:user, role: 'admin'))
    expect(page).to have_selector('li', text: 'Agents')
  end

  scenario 'admin can see customers link' do
    signin(create(:user, role: 'admin'))
    expect(page).to have_selector('li', text: 'Customers')
  end
end
