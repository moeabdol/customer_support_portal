require 'rails_helper'

feature 'search tickets' do
  let!(:ticket1) { create(:ticket, content: 'first ticket.') }
  let!(:ticket2) { create(:ticket, content: 'second ticket.') }
  let(:customer) { create(:customer) }

  context 'admin' do
    before(:example) do
      customer.tickets << ticket1
      customer.tickets << ticket2
      signin(create(:admin))
      visit tickets_path
    end

    scenario 'can find all tickets' do
      fill_in 'search-box', with: 'ticket'
      click_on 'search-button'
      expect(page).to have_selector('td', text: 'first ticket.')
      expect(page).to have_selector('td', text: 'second ticket.')
    end

    scenario 'can find specific ticket' do
      fill_in 'search-box', with: 'first'
      click_on 'search-button'
      expect(page).to have_selector('td', text: 'first ticket.')
      expect(page).not_to have_selector('td', text: 'second ticket.')
    end
  end

  context 'agent' do
    before(:example) do
      customer.tickets << ticket1
      customer.tickets << ticket2
      signin(create(:agent))
      visit tickets_path
    end

    scenario 'can find all tickets' do
      fill_in 'search-box', with: 'ticket'
      click_on 'search-button'
      expect(page).to have_selector('td', text: 'first ticket.')
      expect(page).to have_selector('td', text: 'second ticket.')
    end

    scenario 'can find specific ticket' do
      fill_in 'search-box', with: 'first'
      click_on 'search-button'
      expect(page).to have_selector('td', text: 'first ticket.')
      expect(page).not_to have_selector('td', text: 'second ticket.')
    end
  end
end
