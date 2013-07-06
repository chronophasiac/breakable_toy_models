require 'spec_helper'

feature "User completes personal deck", %Q{
  As a user,
  I want to know when the I've completed my personal deck
  so I can choose to replay my deck or try another lesson.
  } do

  extend LoginHarness
  extend UserDeckHarness
  
  login_as_user
  associate_user_with_cards

  background do
    visit(user_my_deck_path(user))
    fill_in("string-response", with: "foo")
    click_button("Submit")
    click_button("Next")
  end

  scenario "User sees a message that the deck is completed", js: true do
    expect(page).to have_content("Deck completed")
  end

  scenario "User sees a 'Replay' button", js: true do
    click_link("Replay Deck")
    expect(page).to have_content(card.title)
  end

  scenario "User sees an 'Explore Lessons' button", js: true do
    within('.card-container') do
      click_link('Explore Lessons')
    end
    expect(current_path).to include('lessons')
  end
end
