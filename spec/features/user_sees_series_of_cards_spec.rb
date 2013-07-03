require 'spec_helper'

feature "User sees a series of cards", %{
  As a user,
  I want to see a series of cards one at a time
  so I can focus on the card at hand.
  } do

  extend LoginHarness
  extend LessonHarness
  
  login_as_user
  setup_lesson_and_cards_with_string_solutions

  scenario "User sees the current card content", js: true do
    expect(page).to have_content(card1.title)
  end

  scenario "User does not see the next card content", js: true do
    expect(page).to_not have_content(card2.title)
  end

  scenario "User advances to the next card", js: true do
    fill_in("string-response", with: "anything")
    click_button("Submit")
    find("#next")
    expect(page).to have_button("Next")
  end

  scenario "User sees the next card", js: true do
    fill_in("string-response", with: "anything")
    click_button("Submit")
    find("#next").click
    expect(page).to_not have_content(card1.title)
  end

  scenario "User does not see the previous card", js: true do
    fill_in("string-response", with: "anything")
    click_button("Submit")
    find("#next").click
    expect(page).to_not have_content(card1.title)
  end

end
