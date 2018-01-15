require "rails_helper"

feature 'User inputs product URL' do

  user = FactoryGirl.create(:user)
  before { allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user) }

  scenario 'adds product successfully to db and redirects to root' do
    visit product_path
    fill_in 'product[product_url]', with: @product.product_url
    click_button 'Submit'
    expect(current_path).to eq root_path
  end
end
