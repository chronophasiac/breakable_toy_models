require 'spec_helper'

feature 'User signs in', %{
  As a visitor,
  I want to sign in
  so I can resume where I left off
} do

  scenario "User sees a sign in link on the index" do
    visit root_path
    expect(page).to have_link("Sign In")
  end

  scenario "User sees a form that allows them to sign in" do
    visit root_path
    click_link("Sign In")
    expect(page).to have_field("Email")  
    expect(page).to have_field("Password")  
  end

  scenario "User is required to enter email" do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in("Password", with: user.password)
    click_button("Sign in")
    expect(page).to have_content("Invalid email or password")
  end

  scenario "User is required to enter password" do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in("Email", with: user.email)
    click_button("Sign in")
    expect(page).to have_content("Invalid email or password")
  end

  given(:password) { "password" }
  given(:user) { FactoryGirl.create(:user, password: password, password_confirmation: password) }

  background do
    visit new_user_session_path
    fill_in("Email", with: user.email)
    fill_in("Password", with: password)
  end

  scenario "User is signed in after entering a valid email and password" do
    click_button("Sign in")
    expect(page).to have_content("Signed in successfully")
  end

  scenario "User's sign in state is not saved across sessions by default" do
    click_button("Sign in")
    expect(page).to have_content("Signed in successfully")
    expire_cookies
    visit root_path
    expect(page).to have_content("Sign In")
  end

  scenario "User has the option of remembering their signed in state" do
    check("Remember me")
    click_button("Sign in")
    expire_cookies
    visit root_path
    expect(page).to have_content("Sign Out")
  end

  scenario "User sees their signed in state on the nav bar" do
    click_button("Sign in")
    expect(page).to have_content(user.email)
  end

  scenario "User does not see a sign in or sign up link when signed in" do
    click_button("Sign in")
    expect(page).to_not have_content("Sign In")
    expect(page).to_not have_content("Sign Up")
  end

end
