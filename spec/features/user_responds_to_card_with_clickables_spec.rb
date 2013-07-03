require 'spec_helper'
include Warden::Test::Helpers

feature "User responds to challenge card by clicking on the card", %{
  As a user,
  I want to provide a response to a challenge card by clicking on the card
  so I can see if I know the answer to the challenge
  } do

  given(:answer)      { {start: 0, end: 1} }
  given!(:lesson)     { FactoryGirl.create(:lesson) }
  given!(:challenge)  { FactoryGirl.create(:challenge)}
  given!(:card1)      { FactoryGirl.create(:card_position_solution) }
  given!(:answer1)    { FactoryGirl.create(:solution_position, card: card1,
                        start_position: answer[:start], end_position: answer[:end]) }

  given!(:card2)      { FactoryGirl.create(:card_position_solution) }
  given!(:answer2)    { FactoryGirl.create(:solution_position, card: card2,
                        start_position: answer[:start], end_position: answer[:end]) }

  given(:user)        { FactoryGirl.create(:user) }

  background do
    FactoryGirl.create(:challenge_deck, card: card1, challenge: challenge)
    FactoryGirl.create(:challenge_deck, card: card2, challenge: challenge)
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

  scenario "User sees clickable areas on card", js: true do
    expect(page).to have_css(".click-response")
  end

end
