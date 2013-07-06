require 'spec_helper'

feature "User has a deck of cards", %Q{
  As an experienced user,
  I want to have a single deck of cards related to challenges I've done
  to gain mastery in those subjects.
  } do

  extend LoginHarness
  
  login_as_user

  background do
  end

  scenario "User sees a 'Train Now' button on the main page" do
    visit(root_path)
    expect(page).to have_link('Train Now')
  end

  scenario "User sees a 'Train' button on the top nav" do
    visit(lessons_path)
    within('.top-bar') do
      expect(page).to have_link('Train')
    end
  end

  scenario "User sees a card they've experienced before", js: true do
    submission = FactoryGirl.create(:card_submission, user: user)
    log = FactoryGirl.create(:card_submission_log, card_submission: submission)
    card = log.card
    visit(root_path)
    click_link('Train Now')
    expect(page).to have_content(card.title)
  end

end
