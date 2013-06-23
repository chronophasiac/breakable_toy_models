require 'spec_helper'

feature "User signs in as super-admin", %{
  As a user,
  I want to sign in as a super-admin
  so I can manage all data on the site
  } do

  given!(:user)         { FactoryGirl.create(:user) }
  given!(:superadmin)   { FactoryGirl.create(:superadmin) }

  background do
    visit new_user_session_path
    fill_in("Email", with: superadmin.email)
    fill_in("Password", with: superadmin.password)
    click_button("Sign in")
  end

  scenario "User sees a 'Superadmin' link when authorized" do
    expect(page).to have_link("Superadmin")
  end

  scenario "Super-admin sees an admin dashboard" do
    click_link("Superadmin")
    expect(page).to have_css("h1", text: "Site administration")
  end

  scenario "Super-admin sees a 'Users' section with a button to delete a user" do
    click_link("Superadmin")
    within(".sidebar-nav") do
      click_link("Users")
    end
    within first("td.links") do
      expect(page).to have_link("Delete")
    end
  end

  scenario "Super-admin sees that a user has been deleted" do
    FactoryGirl.create(:user)
    click_link("Superadmin")
    within(".sidebar-nav") do
      click_link("Users")
    end
    user_count = User.count
    within first("td.links") do
      click_link("Delete")
    end
    click_button("Yes, I'm sure")
    expect(page).to have_content("User successfully deleted")
    expect(User.count).to eql(user_count - 1)
  end

end
