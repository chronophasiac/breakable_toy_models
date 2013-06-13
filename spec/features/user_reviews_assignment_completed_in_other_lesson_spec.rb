require 'spec_helper'
include Warden::Test::Helpers

feature "User reviews assignment completed in other lesson", %{
  As a user,
  I want to know when I have already completed an assignment from a different lesson
  so I have context when I review assignments.
  } do

  given!(:lesson1)    { FactoryGirl.create(:lesson) }
  given!(:lesson2)    { FactoryGirl.create(:lesson) }
  given!(:assignment) { FactoryGirl.create(:assignment) }
  given(:user)        { FactoryGirl.create(:user) }

  background do
    FactoryGirl.create(:activity, lesson: lesson1, completable: assignment, position: 1)
    FactoryGirl.create(:activity, lesson: lesson2, completable: assignment, position: 1)
    Warden.test_mode!
    login_as(user, scope: :user)
    visit lesson_path(lesson1)
    within first(".assignment") do
      click_button("Start")
    end
    click_button("Done")
  end

  scenario "User sees a 'Review' button on assignments if they've already completed that assignment in another lesson" do
    visit lesson_path(lesson2)
    expect(page.first(".assignment")).to have_button("Review")
    Warden.test_reset!
  end

  scenario "User sees the title of the lesson in which they originally completed the assignment" do
    visit lesson_path(lesson2)
    expect(page.first(".assignment")).to have_content("Completed in #{lesson1.title}")
    Warden.test_reset!
  end

  scenario "User does not see the title of the lesson if they are in the originally completed lesson" do
    visit lesson_path(lesson1)
    expect(page.first(".assignment")).to_not have_content("Completed in #{lesson1.title}")
  end

end
