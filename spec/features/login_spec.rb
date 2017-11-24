require "rails_helper"

feature 'User signs in' do
  let(:user) { FactoryGirl.create(:user) }

  scenario 'with valid credentials' do
    visit login_path
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    click_button 'Submit'
    expect(page).to have_content "This is my web scraper Home page"
  end

  scenario 'with invalid credentials' do
    visit login_path
    fill_in 'email', with: user.email
    fill_in 'password', with: 'password'
    click_button 'Submit'
    expect(current_path).to eq login_path
  end
end
