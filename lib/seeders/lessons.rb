module Seeders
  module Lessons
    class << self
      def seed
        Lesson.destroy_all
        lessons = []

        base_path = 'db/seed_data'
        Dir.glob(Rails.root.join(base_path, 'lessons', '*.yml')) do |file|
          lesson = YAML.load_file(file)
          Lesson.create(title: lesson['title'], summary: lesson['summary'])
        end

        lessons
      end
    end
  end
end
