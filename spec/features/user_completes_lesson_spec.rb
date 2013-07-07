require 'spec_helper'
include Warden::Test::Helpers

feature "User completes lesson", %{
  As a user,
  I want to see when a lesson is completed
  so I can see my progress.
  } do

  given!(:lesson)       { FactoryGirl.create(:lesson) }
  given!(:assignment1)  { FactoryGirl.create(:assignment) }
  given(:user)          { FactoryGirl.create(:user) }

  background do
    FactoryGirl.create(:activity, lesson: lesson, completable: assignment1, position: 1)
    Warden.test_mode!
    login_as(user, scope: :user)
    visit lessons_path
  end

  scenario 'User sees a "Review" button next to a completed lesson' do
    click_button('Start')
    within('.assignment') do
      click_button('Start')
    end
    click_button('Done')
    visit lessons_path
    expect(page).to have_button('Review')
  end

end
