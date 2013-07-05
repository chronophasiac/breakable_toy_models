require 'spec_helper'

feature "User sees completed challenges", %Q{
  As a user,
  I want to see a list of challenges I've completed with the score of each one
  so I can see what material I might want to review.
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

  scenario "User sees a 'Completed Challenges' section in their dashboard", js: true do
    click_link("My Dashboard")
    expect(page).to have_content("Completed Challenges")
    expect(page).to have_content(challenge.title)
  end

  scenario "User sees a list of challenges they have completed, sorted by date"

  scenario "User sees a score for each challenge, and the date they completed it"

end
