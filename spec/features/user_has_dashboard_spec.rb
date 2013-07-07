require 'spec_helper'

feature "User has a dashboard", %Q{
  As a user,
  I want to have a single page all my important information
  so I can plan out my activities in the app.
  } do

  extend LoginHarness
  
  login_as_user

  scenario "User sees lessons in progress" do
    enrollment = FactoryGirl.create(:enrollment, user: user)
    FactoryGirl.create(:activity, lesson: enrollment.lesson)
    visit(root_path)
    within('nav.top-bar') do
      click_link('Dashboard')
    end
    within('.in-progress') do
      expect(page).to have_content(enrollment.lesson.title)
    end
  end
end
