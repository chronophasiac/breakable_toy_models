require 'spec_helper'
include Warden::Test::Helpers


feature "User explores lessons", %{
  As a user,
  I want to see a list of lessons
  so I can choose what to learn.
  } do

  given!(:lesson3)  { FactoryGirl.create(:lesson, title: "Charlie") }
  given!(:lesson1)  { FactoryGirl.create(:lesson, title: "Alpha") }
  given!(:lesson2)  { FactoryGirl.create(:lesson, title: "Bravo") }
  given(:user)      { FactoryGirl.create(:user) }

  background do
    FactoryGirl.create(:activity, lesson: lesson1)
    FactoryGirl.create(:activity, lesson: lesson2)
    FactoryGirl.create(:activity, lesson: lesson3)
    Warden.test_mode!
    login_as(user, scope: :user)
    visit lessons_path
  end

  after :each do
    Warden.test_reset!
  end

  scenario "User sees a list of lessons" do
    visit root_path
    click_link("Lessons")
    expect(page).to have_content(lesson1.title)
  end

  scenario "User sees a list of lessons sorted by title" do
    expect(page.first('.lesson-title')).to have_content(lesson1.title)
  end


  scenario "User sees a start button if they haven't started a lesson" do
    expect(page.first('.lesson-entry')).to have_button("Start")
  end

  scenario "User sees a continue button if they have started a lesson" do
    within first(".lesson-entry") do
      click_button("Start")
    end
    visit lessons_path
    expect(page.first('.lesson-entry')).to have_button("Continue")
  end

end
