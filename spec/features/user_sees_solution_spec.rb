require 'spec_helper'

feature "User sees solution", %Q{
  As a user,
  I want to see the solution to a card if I supply the wrong answer
  so I can learn from my mistakes.
  } do

  extend LoginHarness
  extend LessonHarness
  
  login_as_user
  setup_lesson_and_cards_with_mixed_solutions

  background do
    extend LessonHarness
    associate_mixed_solution_cards_with_challenge_and_init
  end

  scenario "User sees the solution to cards with a position solution", js: true do
    expect(page).to_not have_css('.solution-snippet')
    find("#{wrong_ID}").click
    click_button('position-submit')
    expect(page).to have_content("The correct answer was")
    expect(page).to have_css('.solution-snippet')
    expect(page).to have_css('.solution-position')
  end

  scenario "User sees the solution to cards with a string solution", js: true do
    find("#{correct_ID}").click
    click_button('position-submit')
    click_button('Next')
    expect(page).to_not have_css('.solution-string')
    fill_in("string-response", with: "so wrong")
    click_button("Submit")
    expect(page).to have_content("The correct answer was")
    expect(page).to have_css('.solution-string', text: string_answer)
  end

end
