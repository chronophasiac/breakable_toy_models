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

  scenario "User sees 'Continue lesson' button", js: true do
    click_link('Continue Lesson')
    expect(page).to have_content(lesson.title)
  end

  scenario "User is returned to lesson page on next assignment if button is clicked"

  scenario "User sees 'Repeat challenge' button"

  scenario "User is returned to start of challenge if button is clicked"

  scenario "User sees 'Exit' button"

  scenario "User is returned to main page if button is clicked"

end
