require 'spec_helper'

feature "User is scored based on responses to challenge cards", %Q{
  As a user,
  I want to be scored based on my responses in the challenge
  so I can know how well I did on the challenge overall.
  } do

  extend LoginHarness
  extend LessonHarness
  
  login_as_user
  setup_lesson_and_cards_with_mixed_solutions

  background do
    extend LessonHarness
    associate_mixed_solution_cards_with_challenge_and_init
  end

  scenario "User sees a score when starting the challenge", js: true do
    expect(page).to have_css('#current-score', text: 0)
  end

  scenario "User sees their score go up when they supply a correct response"

  scenario "User does not see their score go up when they supply an incorrect response"

  scenario "User sees a final score at the end of the challenge"

end
