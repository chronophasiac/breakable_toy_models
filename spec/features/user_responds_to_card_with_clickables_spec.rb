require 'spec_helper'

feature "User responds to challenge card by clicking on the card", %{
  As a user,
  I want to provide a response to a challenge card by clicking on the card
  so I can see if I know the answer to the challenge
  } do

  extend LoginHarness
  extend LessonHarness
  
  login_as_user
  setup_lesson_and_cards_with_position_solutions

  background do
    extend LessonHarness
    associate_position_solution_cards_with_challenge_and_init
  end

  scenario "User sees a clickable code snippet", js: true do
    expect(page).to have_css('.clickable-snippet')
  end

  scenario "User does not see a text input field", js: true do
    expect(page).to_not have_field("string-response")
  end

  scenario "User does not see a 'Next' button", js: true do
    expect(page).to_not have_button("Next")
  end

  scenario "User sees clickable areas on card", js: true do
    expect(page).to have_css(".click-response")
  end
  
  scenario %{User sees a submit button that is not activated 
    until at least one area is clicked}, js: true do
    expect(page).to have_css('#position-submit.disabled')
    find("#{correct_ID}").click
    expect(page).to_not have_css('#position-submit.disabled')
    expect(page).to have_css('#position-submit')
  end

  scenario "User sees that their answer is incorrect", js: true do
    user_card_associations = user.cards.length
    expect(page).to_not have_css(".incorrect-indicator")
    expect(page).to_not have_button("Next")
    find("#{wrong_ID}").click
    click_button('position-submit')
    expect(page).to_not have_css(".correct-indicator")
    expect(page).to have_css(".incorrect-indicator")
    user.cards.reload
    expect(user.cards.length).to eql(user_card_associations + 1)
    submission = CardSubmission.last
    log = CardSubmissionLog.last
    expect(log.card_submission_id).to eql(submission.id)
    expect(log.correct).to be_false
  end

  scenario "User sees that their answer is correct", js: true do
    user_card_associations = user.cards.length
    expect(page).to_not have_css(".correct-indicator")
    expect(page).to_not have_button("Next")
    find("#{correct_ID}").click
    click_button('position-submit')
    expect(page).to_not have_css(".incorrect-indicator")
    expect(page).to have_css(".correct-indicator")
    user.cards.reload
    expect(user.cards.length).to eql(user_card_associations + 1)
    submission = CardSubmission.last
    log = CardSubmissionLog.last
    expect(log.card_submission_id).to eql(submission.id)
    expect(log.correct).to be_true
  end

  scenario "User does not see a submit button after providing a response", js: true do
    find("#{correct_ID}").click
    click_button('position-submit')
    expect(page).to_not have_button('position-submit')
  end

  scenario "User advances to the next card", js: true do
    find("#{correct_ID}").click
    click_button('position-submit')
    click_button("Next")
    expect(page).to have_content(card1.instructions)
    expect(page).to_not have_button("Next")
    card_id = CardSubmission.last.card_id
    expect(page).to_not have_content(Card.find(card_id).title)
  end

  scenario "User sees that the clicked token has been selected", js: true do
    expect(page).to_not have_css('.selected-position')
    find("#{correct_ID}").click
    expect(page).to have_css('.selected-position')
  end

  scenario "User sees that the clicked token has been de-selected", js: true do
    expect(page).to_not have_css('.selected-position')
    find("#{correct_ID}").click
    expect(page).to have_css('.selected-position')
    find("#{correct_ID}").click
    expect(page).to_not have_css('.selected-position')
  end

end
