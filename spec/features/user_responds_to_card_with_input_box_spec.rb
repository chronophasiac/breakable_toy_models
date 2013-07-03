require 'spec_helper'
include Warden::Test::Helpers

feature "User responds to challenge card with an input box", %{
  As a user,
  I want to provide a response to a challenge card by typing in an input box
  so I can see if I know the answer to the challenge
  } do

  given(:answer)      {"correctitude"}
  given(:regex)       {"^#{answer}$"}
  given!(:lesson)     { FactoryGirl.create(:lesson) }
  given!(:challenge)  { FactoryGirl.create(:challenge)}
  given!(:card1)      { FactoryGirl.create(:card_string_solution) }
  given!(:answer1)    { FactoryGirl.create(:solution_string, card: card1, regex: regex)}
  given!(:card2)      { FactoryGirl.create(:card_string_solution) }
  given!(:answer2)    { FactoryGirl.create(:solution_string, card: card2, regex: regex)}
  given!(:card3)      { FactoryGirl.create(:card_string_solution) }
  given!(:answer3)    { FactoryGirl.create(:solution_string, card: card3, regex: regex)}
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
    user_card_associations = user.cards.length
    expect(page).to_not have_css(".correct-indicator")
    fill_in("string-response", with: answer)
    click_button("Submit")
    expect(page).to have_css(".correct-indicator")
    user.cards.reload
    expect(user.cards.length).to eql(user_card_associations + 1)
    submission = CardSubmission.last
    log = CardSubmissionLog.last
    expect(log.card_submission_id).to eql(submission.id)
    expect(log.correct).to be_true
  end

  scenario "User sees that their answer is incorrect", js: true do
    user_card_associations = user.cards.length
    expect(page).to_not have_css(".incorrect-indicator")
    fill_in("string-response", with: "this is wrong")
    click_button("Submit")
    expect(page).to_not have_css(".correct-indicator")
    expect(page).to have_css(".incorrect-indicator")
    user.cards.reload
    expect(user.cards.length).to eql(user_card_associations + 1)
    submission = CardSubmission.last
    log = CardSubmissionLog.last
    expect(log.card_submission_id).to eql(submission.id)
    expect(log.correct).to be_false
  end

  scenario "User advances to the next card", js: true do
    fill_in("string-response", with: "this is wrong")
    click_button("Submit")
    click_button("Next")
    expect(page).to have_content(card1.instructions)
    expect(page).to_not have_button("Next")
    card_id = CardSubmission.last.card_id
    expect(page).to_not have_content(Card.find(card_id).title)
  end

end
