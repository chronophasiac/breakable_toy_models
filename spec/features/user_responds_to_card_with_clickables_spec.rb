require 'spec_helper'

feature "User responds to challenge card by clicking on the card", %{
  As a user,
  I want to provide a response to a challenge card by clicking on the card
  so I can see if I know the answer to the challenge
  } do

  extend LoginHarness
  extend LessonHarness
  
  login_as_user
  setup_lesson_and_cards_with_position_solutions

  scenario "User sees clickable areas on card", js: true do
    expect(page).to have_css(".click-response")
  end

end
