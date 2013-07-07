require 'spec_helper'

feature "User sees completed challenges", %Q{
  As a user,
  I want to see a list of challenges I've completed with the score of each one
  so I can see what material I might want to review.
  } do

  extend LoginHarness
  
  login_as_user

  given!(:challenge_completion)  { FactoryGirl.create(:challenge_completion, user: user) }
  given(:challenge)               { challenge_completion.challenge }

  background do
    15.times do
      FactoryGirl.create(:challenge_completion, user: user, updated_at: 5.minutes.ago)
    end
    visit(dashboard_path)
  end

  scenario "User sees a 'Completed Challenges' section in their dashboard" do
    expect(page).to have_content("Completed Challenges")
    expect(page).to have_content(challenge.title)
  end

  scenario "User sees a list of challenges they have completed, sorted by date" do
    within(first('.completed-challenge')) do
      expect(page).to have_content(challenge.title)
    end
  end

  scenario "User sees a score for each challenge, and the date they completed it" do
    within(first('.completed-challenge')) do
      expect(page).to have_content(challenge_completion.score)
      completed_time = challenge_completion.updated_at.localtime.strftime("%e %b %l:%M %p")
      expect(page).to have_content(completed_time)
    end
  end

end
