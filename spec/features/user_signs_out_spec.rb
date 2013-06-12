require 'spec_helper'

feature "User signs out", %{
  As a user,
  I want to log out
  so I don't accidentally share my account.
  } do

  given(:user) { FactoryGirl.create(:user, password: "password", password_confirmation: "password") }

  background do
    visit new_user_session_path
    fill_in("Email", with: user.email)
    fill_in("Password", with: "password")
    click_button("Sign in")
  end

  scenario "User sees 'Sign Out' link when logged in" do
    visit root_path
    click_link(user.email)
    expect(page).to have_content("Sign Out")
  end

  scenario "User sees a message that they have been logged out" do
    visit root_path
    click_link(user.email)
    click_link("Sign Out")
    expect(page).to have_content("Signed out successfully")
  end

end
