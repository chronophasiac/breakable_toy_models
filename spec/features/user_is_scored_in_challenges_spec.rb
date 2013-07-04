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

  scenario "User sees their score go up when they supply a correct response", js: true do
    expect(page).to have_css('#current-score', text: 0)
    find("#{correct_ID}").click
    click_button('position-submit')
    expect(page).to have_css('#current-score', text: 1)
  end

  scenario "User does not see their score go up when they supply an incorrect response", js: true do
    expect(page).to have_css('#current-score', text: 0)
    find("#{wrong_ID}").click
    click_button('position-submit')
    expect(page).to have_css('#current-score', text: 0)
    click_button('Next')
    fill_in("string-response", with: string_answer)
    click_button("Submit")
    expect(page).to have_css('#current-score', text: 1)
  end

end
