require 'factory_girl_rails'

module Seeders
  module Lessons
    class << self
      def seed(options = {})
        Lesson.destroy_all
        lessons = []
        options[:count] ||= 1
        shared_assignment = FactoryGirl.create(:assignment)
        options[:count].times do
          lesson = FactoryGirl.create(:lesson)
          lessons << lesson
          FactoryGirl.create(:activity, lesson: lesson)
          FactoryGirl.create(:activity, lesson: lesson, position: 2)
          FactoryGirl.create(:activity, lesson: lesson, position: 3, completable: FactoryGirl.create(:challenge))
          FactoryGirl.create(:activity, lesson: lesson, position: 4, completable: shared_assignment)
        end
        lessons
      end
    end
  end
end
