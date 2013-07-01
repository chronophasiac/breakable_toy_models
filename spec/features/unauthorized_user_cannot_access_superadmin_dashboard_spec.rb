require 'spec_helper'

feature "Unauthorized user cannot access superadmin dashboard", %{
  As a user without superadmin access
  I should not be able to sign in as superadmin
  so I cannot tamper with the site.
  } do

  given!(:user) { FactoryGirl.create(:user) }

  background do
    user.role = 'student'
    user.save!
    visit new_user_session_path
    fill_in("Email", with: user.email)
    fill_in("Password", with: user.password)
    click_button("Sign in")
  end

  scenario "User does not see a 'Superadmin' link" do
    expect(page).to_not have_link("Superadmin")
  end

  scenario "User sees an 'Unauthorized' message they attempt to access the Superadmin dashboard" do
    visit rails_admin_path
    expect(page).to_not have_css("h1", text: "Site administration")
    expect(page).to have_content("You are not authorized to access this page")
  end

end
