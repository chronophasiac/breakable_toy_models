require 'spec_helper'
include Warden::Test::Helpers

feature "User manages account", %{
  As a user,
  I want to manage my account
  so I have control over my relationship with the app
  } do

  given(:password)  { "swordfish" }
  given(:user)      { FactoryGirl.create(:user, password: password, password_confirmation: password) }

  background do
    Warden.test_mode!
    login_as(user, scope: :user)
    visit root_path
    click_link(user.email)
  end

  after :each do
    Warden.test_reset!
  end

  scenario "User sees account management link on the nav bar" do
    expect(page).to have_content("Manage Account")
  end

  scenario "User sees a form to change account detail" do
    click_link("Manage Account")
    expect(page).to have_css("h3", text: "Manage Account")
    expect(page).to have_field("user_email")
    expect(page).to have_field("user_password")
    expect(page).to have_field("user_password_confirmation")
    expect(page).to have_field("user_current_password")
  end

  scenario "User is required to enter their current password" do
    click_link("Manage Account")
    click_button("Update")
    expect(page).to have_css(".user_current_password", text: "can't be blank")
  end

  scenario "User can change email" do
    click_link("Manage Account")
    new_email = "lester@horrible.com"
    fill_in("user_email", with: new_email)
    fill_in("user_current_password", with: password)
    click_button("Update")
    user.reload
    confirmation_link = "/users/confirmation?confirmation_token=#{user.confirmation_token}"
    visit confirmation_link
    user.reload
    expect(user.email).to eql(new_email)
  end

  scenario "User can change password" do
    click_link("Manage Account")
    new_password = "donthackmebro"
    fill_in("user_password", with: new_password)
    fill_in("user_password_confirmation", with: new_password)
    fill_in("user_current_password", with: password)
    prev_encrypted_password = user.encrypted_password
    click_button("Update")
    user.reload
    expect(user.encrypted_password).to_not eql(prev_encrypted_password)
  end

  scenario "User can delete their account" do
    click_link("Manage Account")
    fill_in("user_current_password", with: password)
    click_link("Cancel my account")
    expect(User.all).to_not include(user)
  end

end
