require 'spec_helper'
include Warden::Test::Helpers


feature "User explores lessons", %{
  As a user,
  I want to see a list of lessons
  so I can choose what to learn.
  } do

  scenario "User sees a list of lessons" do
    lesson = FactoryGirl.create(:lesson)
    visit root_path
    click_link("Lessons")
    expect(page).to have_content(lesson.title)
  end

  let!(:lesson3) { FactoryGirl.create(:lesson, title: "Charlie") }
  let!(:lesson1) { FactoryGirl.create(:lesson, title: "Alpha") }
  let!(:lesson2) { FactoryGirl.create(:lesson, title: "Bravo") }

  scenario "User sees a list of lessons sorted by title" do
    visit lessons_path
    expect(page.first('.lesson-title')).to have_content(lesson1.title)
  end

  let!(:user) { FactoryGirl.create(:user) }

  scenario "User sees a start button if they haven't started a lesson" do
    Warden.test_mode!
    login_as(user, scope: :user)
    visit lessons_path
    expect(page.first('.lesson-entry')).to have_button("Start")
    Warden.test_reset!
  end

  scenario "User sees a continue button if they have started a lesson" do
    Warden.test_mode!
    login_as(user, scope: :user)
    visit lessons_path
    within first(".lesson-entry") do
      click_button("Start")
    end
    visit lessons_path
    expect(page.first('.lesson-entry')).to have_button("Continue")
    Warden.test_reset!
  end

end
