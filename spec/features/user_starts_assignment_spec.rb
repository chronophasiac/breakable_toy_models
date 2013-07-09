require 'spec_helper'
include Warden::Test::Helpers

feature "User starts assignment", %{
  As a user,
  I want to see relevant learning material when I've started an assignment
  so I can prepare myself for the challenge.
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

  after :each do
    Warden.test_reset!
  end

  scenario "User sees a start button on an assignment" do
    expect(page.first(".assignment")).to have_button("Start")
  end

  scenario "User sees instructions" do
    within first(".assignment") do
      click_button("Start")
    end
    expect(page).to have_content(assignment1.instructions)
  end

  scenario "User sees a link to learning material" do
    within first(".assignment") do
      click_button("Start")
    end
    expect(page).to have_link("Start", href: assignment1.url)
  end

  scenario "User sees a start button if they haven't started an assignment" do
    expect(page.first(".assignment")).to have_button("Start")
  end

  scenario "User sees a continue button if they have started an assignment" do
    within first(".assignment") do
      click_button("Start")
    end
    visit lesson_path(lesson)
    expect(user.assignments).to include(assignment1)
    expect(page.first(".assignment")).to have_button("Continue")
  end

end
