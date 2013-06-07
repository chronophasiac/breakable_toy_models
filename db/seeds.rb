require 'factory_girl_rails'

user = FactoryGirl.create(:user)

50.times do 
    lesson = FactoryGirl.create(:lesson)
    assignment = FactoryGirl.create(:assignment)
    syllabus = FactoryGirl.create(:syllabus, lesson: lesson, assignment: assignment)
end
