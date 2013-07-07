require 'spec_helper'

feature "User experiences spaced repetition", %Q{
  As an experienced user,
  I want my deck to train me in my areas of weakness more often
  so I can retain that information.
  } do

  extend LoginHarness
  extend UserDeckHarness
  
  login_as_user
  associate_user_with_varying_responses

  scenario "User sees a card they've previously gotten wrong", js: true do
    visit(user_my_deck_path(user))
    expect(page).to have_content(incorrect_submission.card.title)
  end

end
