require 'spec_helper'

feature "User has a dashboard", %Q{
  As a user,
  I want to have a single page all my important information
  so I can plan out my activities in the app.
  } do

  extend LoginHarness
  extend UserDeckHarness
  
  login_as_user
  associate_user_with_varying_responses

  let!(:enrollment)           { FactoryGirl.create(:enrollment, user: user) }
  let!(:coursework)           { FactoryGirl.create(:coursework, user: user) }
  let!(:completed_coursework)  { FactoryGirl.create(:coursework, user: user, completed: true) }

  background do
    FactoryGirl.create(:activity, lesson: enrollment.lesson)
    visit(root_path)
    within('nav.top-bar') do
      click_link('Dashboard')
    end
  end

  scenario "User sees lessons in progress" do
    within('.in-progress') do
      click_link(enrollment.lesson.title)
    end
    expect(page).to have_content(enrollment.lesson.title)
  end

  scenario "User sees assignments in progress" do
    within('.in-progress') do
      click_link(coursework.assignment.title)
    end
    expect(page).to have_content(coursework.assignment.title)
  end

  scenario "User sees completed assignments" do
    within('.achievements') do
      click_link(completed_coursework.assignment.title)
    end
    expect(page).to have_content(completed_coursework.assignment.title)
  end

  scenario "User sees list of cards with next repetition for each one" do
    within('.card-queue') do
      expect(page).to have_content(submission1.card.title)
      expect(page).to have_content(submission1.sm2_next_repetition.to_formatted_s(:short))
    end
  end

  scenario "User sees a button to train" do
    within('.card-queue') do
      expect(page).to have_button("Train Now")
    end
  end

end
