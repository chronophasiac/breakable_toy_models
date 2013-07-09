require 'spec_helper'

feature "User has a deck of cards", %Q{
  As an experienced user,
  I want to have a single deck of cards related to challenges I've done
  to gain mastery in those subjects.
  } do

  extend LoginHarness
  extend UserDeckHarness
  
  login_as_user
  associate_user_with_cards

  background do
    visit(root_path)
  end

  scenario "User sees a 'Practice Now' button on the main page" do
    expect(page).to have_link('Practice Now')
  end

  scenario "User sees a 'Practice' button on the top nav" do
    within('.top-bar') do
      expect(page).to have_link('Practice')
    end
  end

  scenario "User sees a card they've experienced before", js: true do
    click_link('Practice Now')
    expect(page).to have_content(card.title)
  end

  scenario "User does not see a score", js: true do
    click_link('Practice Now')
    expect(page).to_not have_css('.score-container')
  end

  scenario %Q{User sees a message that they haven't
    completed any cards if they have no cards}, js: true do
    CardSubmission.destroy_all
    click_link('Practice Now')
    expect(page).to have_content("Sorry, you haven't completed any cards yet")
  end

  scenario "User sees a link to lessons", js: true do
    CardSubmission.destroy_all
    click_link('Practice Now')
    within('.card-container') do
      click_link('Explore Lessons')
    end
    expect(current_path).to include('lessons')
  end

end
