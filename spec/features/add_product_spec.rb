require "rails_helper"

feature 'User inputs product URL' do

  let(:user) { create(:user) }
  let(:product) { create(:product, id: 1, name: "shoe") }
  before { allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user) }

  scenario 'adds product successfully to db and redirects to root' do
    visit new_product_path
    fill_in 'product[product_url]', with: product.product_url
    click_button 'Submit'
    expect(current_path).to eq "/users/#{user.id}"
  end
end
