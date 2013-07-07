require 'spec_helper'

feature "User has a dashboard", %Q{
  As a user,
  I want to have a single page all my important information
  so I can plan out my activities in the app.
  } do

  extend LoginHarness
  
  login_as_user

  let!(:enrollment) { FactoryGirl.create(:enrollment, user: user) }
  let!(:coursework) { FactoryGirl.create(:coursework, user: user) }

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
end
