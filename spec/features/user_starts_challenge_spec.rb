require 'spec_helper'
include Warden::Test::Helpers

feature "User starts challenge", %{
  As a user,
  I want to start a challenge
  so I can test my knowledge of the material
  } do

  given!(:lesson)     { FactoryGirl.create(:lesson) }
  given!(:challenge)  { FactoryGirl.create(:challenge)}
  given!(:card)       { FactoryGirl.create(:card_string_solution) }
  given(:user)        { FactoryGirl.create(:user) }

  background do
    FactoryGirl.create(:challenge_deck, card: card, challenge: challenge)
    FactoryGirl.create(:activity, lesson: lesson, completable: challenge)
    Warden.test_mode!
    login_as(user, scope: :user)
    visit lesson_path(lesson)
  end

  after :each do
    Warden.test_reset!
  end

  scenario "User sees a challenge title in the lesson" do
    expect(page).to have_content(challenge.title)
  end

  scenario "User sees a 'Start' button adjacent to the title" do
    within first(".challenge") do
      click_button("Start")
    end
    expect(page).to have_content(challenge.title)
  end

  scenario "User sees a card with a title" do
    within first(".challenge") do
      click_button("Start")
    end
    expect(page).to have_content(card.title)
  end

  scenario "User sees a card with instructions on how to submit a response" do
    within first(".challenge") do
      click_button("Start")
    end
    expect(page).to have_content("Instructions: #{card.instructions}")
  end

  scenario "User sees a card with a problem" do
    within first(".challenge") do
      click_button("Start")
    end
    expect(page).to have_content(card.problem)
  end

end
