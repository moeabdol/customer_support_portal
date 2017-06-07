require 'rails_helper'

feature 'sign in' do
  scenario 'user cannot sign in when not registered' do
    user = build(:user)
    signin(user)
    expect(page).to have_selector('.alert', text: 'Invalid Email or password.')
  end

  scenario 'user can sign in with valid credintials' do
    user = create(:user)
    signin(user)
    expect(page).to have_selector('.alert', text: 'Signed in successfully.')
  end

  scenario 'user cannot sign in with invalid email' do
    user = create(:user)
    visit new_user_session_path
    fill_in 'user_email', with: 'person@example.com'
    fill_in 'user_password', with: user.password
    click_on 'user_login_button'
    expect(page).to have_selector('.alert', text: 'Invalid Email or password.')
  end

  scenario 'user cannot sign in with invalid password' do
    user = create(:user)
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: 'password'
    click_on 'user_login_button'
    expect(page).to have_selector('.alert', text: 'Invalid Email or password.')
  end
end
