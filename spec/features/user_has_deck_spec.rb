require 'spec_helper'

feature "User has a deck of cards", %Q{
  As an experienced user,
  I want to have a single deck of cards related to challenges I've done
  to gain mastery in those subjects.
  } do

  extend LoginHarness
  
  login_as_user

  let(:submission)  { FactoryGirl.create(:card_submission, user: user) }
  let(:log)         { FactoryGirl.create(:card_submission_log,
                      card_submission: submission) }
  let!(:card)       { log.card }

  background do
    visit(root_path)
  end

  scenario "User sees a 'Train Now' button on the main page" do
    expect(page).to have_link('Train Now')
  end

  scenario "User sees a 'Train' button on the top nav" do
    within('.top-bar') do
      expect(page).to have_link('Train')
    end
  end

  scenario "User sees a card they've experienced before", js: true do
    click_link('Train Now')
    expect(page).to have_content(card.title)
  end

  scenario "User does not see a score", js: true do
    click_link('Train Now')
    expect(page).to_not have_css('.score-container')
  end

  scenario %Q{User sees a message that they haven't
    completed any cards if they have no cards}, js: true do
    CardSubmission.destroy_all
    click_link('Train Now')
    expect(page).to have_content("Sorry, you haven't completed any cards yet")
  end

  scenario "User sees a link to lessons", js: true do
    CardSubmission.destroy_all
    click_link('Train Now')
    within('.card-container') do
      click_link('Explore Lessons')
    end
    expect(current_path).to include('lessons')
  end

end
