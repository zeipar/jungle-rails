require 'rails_helper'

RSpec.feature "Visitor logs in and is directed to home page when successfully logged in", type: :feature, js: true do

  # SETUP
  before :each do
    User.create!(
      first_name: "tester1", 
      last_name: "erer", 
      email: "zeipar@gmail.com", 
      password: "lalala", 
      password_confirmation: "lalala")
  end

  scenario "They click on login button on the top nav" do
    # ACT
    visit login_path
    fill_in "email", with: "zeipar@gmail.com"
    fill_in "password", with: "lalala"

    click_button("Submit")

    # DEBUG
    save_screenshot

    # VERIFY
    expect(page).to have_content 'tester1'
  end

end