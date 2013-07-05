require 'spec_helper'

feature "User responds to challenge card with an input box", %{
  As a user,
  I want to provide a response to a challenge card by typing in an input box
  so I can see if I know the answer to the challenge
  } do
  
  extend LoginHarness
  extend LessonHarness

  login_as_user
  setup_lesson_and_cards_with_string_solutions
  
  background do
    extend LessonHarness
    associate_string_solution_cards_with_challenge_and_init
  end

  scenario "User sees an input box", js: true do
    expect(page).to have_field("string-response")
  end

  scenario "User does not see a clickable code snippet", js: true do
    expect(page).to_not have_css('.clickable-snippet')
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

  scenario "User does not see an input field after providing an incorrect answer", js: true do
    fill_in("string-response", with: "this is wrong")
    click_button("Submit")
    expect(page).to_not have_field("string-response")
  end

  scenario "User does not see an input field after providing a correct answer", js: true do
    fill_in("string-response", with: answer)
    click_button("Submit")
    expect(page).to_not have_field("string-response")
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
