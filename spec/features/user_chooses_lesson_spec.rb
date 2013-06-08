require 'spec_helper'

feature "User chooses a lesson", %{
  As a user,
  I want to see an overview of the assignments and challenges in a lesson
  so I can take in what is involved in a lesson with a glance.
} do

  given!(:lesson) { FactoryGirl.create(:lesson) }
  given!(:challenge) { FactoryGirl.create(:challenge, lesson: lesson, position: 3) }
  given!(:assignment2) { FactoryGirl.create(:assignment) }
  given!(:assignment1) { FactoryGirl.create(:assignment) }

  background do
    FactoryGirl.create(:syllabus, lesson: lesson, assignment: assignment2, position: 2)
    FactoryGirl.create(:syllabus, lesson: lesson, assignment: assignment1, position: 1)
    visit lessons_path
    click_link(lesson.title)
  end

  scenario "User selects a lesson" do
    expect(page).to have_content(assignment2.title)
  end

  scenario "User sees a list of assignments and challenges" do
    expect(page).to have_content(assignment1.title)
    expect(page).to have_content(assignment1.instructions)
    expect(page).to have_content(challenge.title)
  end 

  scenario "User sees a list in the correct order" do
    within ".assignment:first-child" do
      expect(page).to have_content(assignment1.title)
    end
  end

end
