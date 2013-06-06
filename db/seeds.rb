require 'factory_girl_rails'

user = FactoryGirl.create(:user)

100.times do 
  FactoryGirl.create(:lesson)
end
