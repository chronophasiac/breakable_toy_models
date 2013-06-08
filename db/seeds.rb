require 'factory_girl_rails'

user = FactoryGirl.create(:user)

30.times do 
    lesson = FactoryGirl.create(:lesson)
end
