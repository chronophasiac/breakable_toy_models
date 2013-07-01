require 'spec_helper'
include Warden::Test::Helpers

feature "User responds to challenge card with an input box", %{
  As a user,
  I want to provide a response to a challenge card by typing in an input box
  so I can verify if I know the answer to the challenge
  } do

  given!(:lesson)     { FactoryGirl.create(:lesson) }
  given!(:challenge)  { FactoryGirl.create(:challenge)}
  given!(:card1)      { FactoryGirl.create(:card_string_solution) }
  given!(:answer1)    { FactoryGirl.create(:solution_string, card: card1)}
  given!(:card2)      { FactoryGirl.create(:card_string_solution) }
  given!(:answer2)    { FactoryGirl.create(:solution_string, card: card2)}
  given!(:card3)      { FactoryGirl.create(:card_string_solution) }
  given!(:answer3)    { FactoryGirl.create(:solution_string, card: card3)}
  given(:user)        { FactoryGirl.create(:user) }

  background do
    FactoryGirl.create(:challenge_deck, card: card1, challenge: challenge)
    FactoryGirl.create(:challenge_deck, card: card2, challenge: challenge)
    FactoryGirl.create(:challenge_deck, card: card3, challenge: challenge)
    FactoryGirl.create(:activity, lesson: lesson, completable: challenge)
    Warden.test_mode!
    login_as(user, scope: :user)
    visit lesson_path(lesson)
    within first(".challenge") do
      click_button("Start")
    end
  end

  after :each do
    Warden.test_reset!
  end

  scenario "User sees an input box", js: true do
    expect(page).to have_field("string-response")
  end

  scenario "User sees a submit button", js: true do
    expect(page).to have_button("Submit")
  end

  scenario "User does not see a 'Next' button", js: true do
    expect(page).to_not have_button("Next")
  end

  scenario "User sees that their answer is correct", js: true do
    expect(page).to_not have_css(".correct-indicator")
    fill_in("string-response", with: answer1.regex)
    click_button("Submit")
    expect(page).to have_css(".correct-indicator")
  end

end
