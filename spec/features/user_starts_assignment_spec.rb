require 'spec_helper'
include Warden::Test::Helpers

feature "User starts assignment", %{
  As a user,
  I want to see relevant learning material when I've started an assignment
  so I can prepare myself for the challenge.
  } do

  given!(:lesson) { FactoryGirl.create(:lesson) }
  given!(:assignment1) { FactoryGirl.create(:assignment) }
  given!(:assignment2) { FactoryGirl.create(:assignment) }

  background do
    FactoryGirl.create(:activity, lesson: lesson, completable: assignment1, position: 1)
    FactoryGirl.create(:activity, lesson: lesson, completable: assignment2, position: 2)
    visit lesson_path(lesson)
  end

  scenario "User sees a start button on an assignment" do
    expect(page.first(".assignment")).to have_button("Start")
  end

  scenario "User sees learning material after clicking start" do
    within first(".assignment") do
      click_button("Start")
    end
    expect(page).to have_content(assignment1.instructions)
  end

  given(:user) { FactoryGirl.create(:user) }

  scenario "User sees a start button if they haven't started an assignment" do
    Warden.test_mode!
    login_as(user, scope: :user)
    visit lesson_path(lesson)
    expect(page.first(".assignment")).to have_button("Start")
    Warden.test_reset!
  end

  scenario "User sees a continue button if they have started an assignment" do
    Warden.test_mode!
    login_as(user, scope: :user)
    visit lesson_path(lesson)
    within first(".assignment") do
      click_button("Start")
    end
    visit lesson_path(lesson)
    expect(user.assignments).to include(assignment1)
    expect(page.first(".assignment")).to have_button("Continue")
    Warden.test_reset!
  end

end
