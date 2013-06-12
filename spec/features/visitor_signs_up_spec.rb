require 'spec_helper'

feature "Visitor signs up", %{
  As a visitor,
  I want to sign up
  so I can save my progress and receive updates.
  } do

  scenario "Visitor sees a sign up link on the index" do
    visit root_path
    expect(page).to have_link("Sign Up")
  end

  scenario "Visitor sees a form that allows them to sign up" do
    visit root_path
    click_link("Sign Up")
    expect(page).to have_field("Email")  
    expect(page).to have_field("Password")  
    expect(page).to have_field("Password confirmation")  
  end

  scenario "Visitor is required to provide a unique email" do
    user = FactoryGirl.create(:user)
    prev_user_count = User.count
    visit new_user_registration_path
    fill_in("Email", with: user.email)
    fill_in("user_password", with: "password")
    fill_in("user_password_confirmation", with: "password")
    click_button("Sign up")
    expect(User.count).to eql(prev_user_count)
    expect(page).to have_content("has already been taken")
  end

  scenario "Visitor is required to provide a strong password" do
    prev_user_count = User.count
    visit new_user_registration_path
    fill_in("Email", with: "foo@bar.com")
    fill_in("user_password", with: "weak")
    fill_in("user_password_confirmation", with: "weak")
    click_button("Sign up")
    expect(User.count).to eql(prev_user_count)
    expect(page).to have_content("is too short")
  end

  scenario "Visitor is required to confirm their password" do
    prev_user_count = User.count
    visit new_user_registration_path
    fill_in("Email", with: "foo@bar.com")
    fill_in("user_password", with: "password")
    fill_in("user_password_confirmation", with: "otherpassword")
    click_button("Sign up")
    expect(User.count).to eql(prev_user_count)
    expect(page).to have_content("doesn't match")
  end

  scenario "Visitor is signed in after completing the form" do
    prev_user_count = User.count
    visit new_user_registration_path
    expect(page).to_not have_content("Logout")
    fill_in("Email", with: "foo@bar.com")
    fill_in("user_password", with: "password")
    fill_in("user_password_confirmation", with: "password")
    click_button("Sign up")
    expect(User.count).to eql(prev_user_count + 1)
    expect(page).to have_content("signed up successfully")
  end

  scenario "Visitor sees a sign up link after doing challenges"
end
