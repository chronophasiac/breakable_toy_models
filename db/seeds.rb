require 'factory_girl_rails'

user = FactoryGirl.create(:user)

30.times do 
    lesson = FactoryGirl.create(:lesson)
    assignment = FactoryGirl.create(:assignment)
    assignment2 = FactoryGirl.create(:assignment)
    FactoryGirl.create(:syllabus, lesson: lesson, assignment: assignment2, position: 2)
    FactoryGirl.create(:syllabus, lesson: lesson, assignment: assignment, position: 1)
    challenge = FactoryGirl.create(:challenge, lesson: lesson, position: 3)
end
