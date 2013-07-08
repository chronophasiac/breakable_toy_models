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
            elsif activity['type'] == 'Challenge'
              completable = Challenge.create do |challenge|
                challenge.title = activity['title']
              end
              activity['cards'].each do |card|
                new_card = Card.create do |c|
                  c.title = card['title']
                  c.instructions = card['instructions']
                  c.problem = card['problem']
                  c.solution_type = card['solution_type']
                  c.snippet = card['snippet'] if card['snippet'].present?
                end
                card['solutions'].each do |solution|

                  if card['solution_type'] == 'string'
                    sol = new_card.solution_strings.create do |solution_string|
                      solution_string.regex = solution['regex']
                      solution_string.canonical = true if solution['canonical']
                    end
                  elsif card['solution_type'] == 'position'
                    sol = new_card.solution_positions.create do |solution_position|
                      solution_position.start_position = solution['start_position']
                      solution_position.end_position = solution['end_position']
                    end
                  end

                  completable.cards << new_card
                end
              end
            end

            Activity.create do |lesson_activity|
              lesson_activity.completable = completable
              lesson_activity.lesson = this_lesson
              lesson_activity.position = index + 1
            end
          end
        end

        lessons
      end
    end
  end
end
