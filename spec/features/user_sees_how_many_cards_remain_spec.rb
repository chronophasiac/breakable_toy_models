require 'spec_helper'

feature "User sees how many cards are remaining in challenge", %Q{
  As a user,
  I want to know how many cards are left in a challenge
  so I can properly manage my time.
  } do

  extend LoginHarness
  extend LessonHarness
  
  login_as_user
  setup_lesson_and_cards_with_mixed_solutions

  background do
    extend LessonHarness
    associate_mixed_solution_cards_with_challenge_and_init
  end

  scenario "User sees the number of cards in a challenge", js: true do
    expect(page).to have_css('#cards-remaining', text: 2)
  end

  scenario %Q{User sees there is 1 card remaining when they are on
    the last card in the challenge}, js: true do
    expect(page).to have_css('#cards-remaining', text: 2)
    find("#{correct_ID}").click
    click_button('position-submit')
    click_button('Next')
    expect(page).to have_css('#cards-remaining', text: 1)
  end

end
