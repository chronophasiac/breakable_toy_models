require 'spec_helper'

feature "User chooses a lesson", %{
  As a user,
  I want to see a list of lessons
  so I can choose what to learn.
} do

  # given(:user) { FactoryGirl.create(:user, password: "password", password_confirmation: "password") }

  # background do
  #   visit new_user_session_path
  #   fill_in("Email", with: user.email)
  #   fill_in("Password", with: "password")
  #   click_button("Sign in")
  # end

  scenario "User sees a list of lessons" do
    lesson = FactoryGirl.create(:lesson)
    visit root_path
    click_link("Lessons")
    expect(page).to have_content(lesson.title)
  end

  scenario "User sees a list of lessons sorted by title" do
    lesson1 = FactoryGirl.create(:lesson, title: "Charlie")
    lesson2 = FactoryGirl.create(:lesson, title: "Alpha")
    lesson3 = FactoryGirl.create(:lesson, title: "Bravo")
    visit lessons_path
    expect(page.first('.lesson-title')).to have_content("Alpha")
  end

end
