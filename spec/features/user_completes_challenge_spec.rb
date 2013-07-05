require 'spec_helper'

feature "User completes challenge", %Q{
  As a user,
  I want to know when the challenge is over
  so I can choose to continue the lesson, repeat, or exit.
  } do

  extend LoginHarness
  extend LessonHarness
  
  login_as_user
  setup_lesson_and_cards_with_mixed_solutions

  background do
    extend LessonHarness
    associate_mixed_solution_cards_with_challenge_and_init
    find("#{correct_ID}").click
    click_button('position-submit')
    click_button('Next')
    fill_in("string-response", with: string_answer)
    click_button("Submit")
    click_button('Next')
  end

  scenario "User sees a message that the challenge is over", js: true do
    expect(page).to have_content("Challenge completed")
  end

  scenario "User sees final score for the challenge", js: true do
    expect(page).to have_css('#final-score', text: 2)
  end

  scenario "User sees 'Continue Lesson' button", js: true do
    click_link('Continue Lesson')
    expect(page).to have_content(lesson.title)
  end

  scenario "User sees 'Repeat challenge' button", js: true do
    click_link('Repeat Challenge')
    expect(page).to have_content(challenge.title)
    expect(page).to have_content(card1.title)
  end

  scenario "User sees 'Return to Home' button", js: true do
    click_link('Return to Home')
    expect(page).to have_content('Learn stuff')
  end

end
