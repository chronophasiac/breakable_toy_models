module Seeders
  module Lessons
    class << self
      def seed
        Lesson.destroy_all
        lessons = []

        base_path = 'db/seed_data'
        Dir.glob(Rails.root.join(base_path, 'lessons', '*.yml')) do |file|
          lesson = YAML.load_file(file)
          this_lesson = Lesson.create(title: lesson['title'], summary: lesson['summary'])
          lessons << this_lesson
          lesson['activities'].each_with_index do |activity, index|
            completable = []
            if activity['type'] == 'Assignment'
              completable = Assignment.create do |assignment|
                assignment.title = activity['title']
                assignment.summary = activity['summary']
                assignment.instructions = activity['instructions']
                assignment.url = activity['url']
                assignment.assignment_type = activity['assignment_type']
              end
            end
            Activity.create do |activity|
              activity.completable = completable
              activity.lesson = this_lesson
              activity.position = index + 1
            end
          end
        end

        lessons
      end
    end
  end
end
