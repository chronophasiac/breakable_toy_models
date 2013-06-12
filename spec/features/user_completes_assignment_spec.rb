require 'spec_helper'
include Warden::Test::Helpers

feature "User completes assignment", %{
  As a user,
  I want to mark my assignment as completed
  so I can track my progress through the lesson.
  } do

  given!(:lesson)       { FactoryGirl.create(:lesson) }
  given!(:assignment1)  { FactoryGirl.create(:assignment) }
  given!(:assignment2)  { FactoryGirl.create(:assignment) }
  given(:user)          { FactoryGirl.create(:user) }

  background do
    FactoryGirl.create(:activity, lesson: lesson, completable: assignment1, position: 1)
    FactoryGirl.create(:activity, lesson: lesson, completable: assignment2, position: 2)
    Warden.test_mode!
    login_as(user, scope: :user)
    visit lesson_path(lesson)
  end

  scenario "User sees a done button on the assignment" do
    within first(".assignment") do
      click_button("Start")
    end
    expect(page).to have_button("Done")
    Warden.test_reset!
  end

  scenario "User sees that lesson is completed after clicking 'Done'" do
    within first(".assignment") do
      click_button("Start")
    end
    click_button("Done")
    expect(page.first(".assignment")).to have_button("Review")
    Warden.test_reset!
  end

  scenario "User does not see a 'done' button if assignment is already completed" do
    within first(".assignment") do
      click_button("Start")
    end
    click_button("Done")
    within first(".assignment") do
      click_button("Review")
    end
    expect(page).to_not have_button("Done")
    Warden.test_reset!
  end

end
