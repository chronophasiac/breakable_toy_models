require 'factory_girl_rails'

user = FactoryGirl.create(:user)

30.times do 
    lesson = FactoryGirl.create(:lesson)
    FactoryGirl.create(:activity, lesson: lesson)
    FactoryGirl.create(:activity, lesson: lesson, position: 2)
    activity = FactoryGirl.create(:activity, lesson: lesson, position: 3, completable: FactoryGirl.create(:challenge))
end
