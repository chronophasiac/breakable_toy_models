require 'spec_helper'

feature "User chooses a lesson", %{
  As a user,
  I want to see an overview of the assignments and challenges in a lesson
  so I can take in what is involved in a lesson with a glance.
} do

  scenario "User selects a lesson" do
    lesson = FactoryGirl.create(:lesson)
    assignment = FactoryGirl.create(:assignment)
    syllabus = FactoryGirl.create(:syllabus, lesson: lesson, assignment: assignment)
    visit lessons_path
    click_link(lesson.title)
    expect(page).to have_content(assignment.title)
  end

end
