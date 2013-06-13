require 'factory_girl_rails'

user = FactoryGirl.create(:user)

20.times do 
  lesson = FactoryGirl.create(:lesson)
  activity1 = FactoryGirl.create(:activity, lesson: lesson)
  activith2 = FactoryGirl.create(:activity, lesson: lesson, position: 2)
  challenge = FactoryGirl.create(:activity, lesson: lesson, position: 3, completable: FactoryGirl.create(:challenge))
end

assignment = FactoryGirl.create(:assignment)
lesson1 = FactoryGirl.create(:lesson)
lesson2 = FactoryGirl.create(:lesson)
FactoryGirl.create(:activity, lesson: lesson1, completable: assignment)
FactoryGirl.create(:activity, lesson: lesson2, completable: assignment)
