require 'spec_helper'
include Warden::Test::Helpers

feature "User sees a series of cards", %{
  As a user,
  I want to see a series of cards one at a time
  so I can focus on the card at hand.
  } do

  given!(:lesson)     { FactoryGirl.create(:lesson) }
  given!(:challenge)  { FactoryGirl.create(:challenge)}
  given!(:card1)       { FactoryGirl.create(:card_string_solution) }
  given!(:card2)       { FactoryGirl.create(:card_string_solution) }
  given!(:card3)       { FactoryGirl.create(:card_string_solution) }
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

  scenario "User sees the current card content" do
    expect(page).to have_content(card1.title)
  end

  scenario "User does not see the next card content" do
    expect(page).to_not have_content(card2.title)
  end

  scenario "User advances to the next card"
  scenario "User sees the next card"
  scenario "User does not see the previous card"

end
