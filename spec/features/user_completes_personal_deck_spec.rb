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
  end

  scenario "User sees a message that the deck is completed", js: true do
    fill_in("string-response", with: "foo")
    click_button("Submit")
    click_button("Next")
    expect(page).to have_content("Deck completed")
  end

end
