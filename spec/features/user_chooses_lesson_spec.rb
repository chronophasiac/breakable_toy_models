require 'spec_helper'

feature "User chooses a lesson", %{
  As a user,
  I want to see an overview of the assignments and challenges in a lesson
  so I can take in what is involved in a lesson with a glance.
} do

  given!(:lesson) { FactoryGirl.create(:lesson) }
  given!(:challenge) { FactoryGirl.create(:challenge) }
  given!(:assignment1) { FactoryGirl.create(:assignment) }
  given!(:assignment2) { FactoryGirl.create(:assignment) }

  background do
    FactoryGirl.create(:activity, lesson: lesson, completable: challenge, position: 3)
    FactoryGirl.create(:activity, lesson: lesson, completable: assignment1, position: 1)
    FactoryGirl.create(:activity, lesson: lesson, completable: assignment2, position: 2)
  end

  background do
    visit lessons_path
    click_link(lesson.title)
  end

  scenario "User selects a lesson" do
    expect(page).to have_content(assignment2.title)
  end

  scenario "User sees a list of assignments and challenges" do
    expect(page).to have_content(assignment1.title)
    expect(page).to have_content(assignment1.summary)
    expect(page).to have_content(challenge.title)
  end 

  scenario "User sees a list in the correct order" do
    within first(".assignment") do
      expect(page).to have_content(assignment1.title)
    end
  end

end
