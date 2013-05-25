class LessonAssignment < ActiveRecord::Base
  attr_accessible :assignment_id, :lesson_id, :position

  validates_presence_of :lesson_id
  validates_presence_of :assignment_id
  validates_presence_of :position

  belongs_to  :assignment,
              inverse_of: :lesson_assignment

  belongs_to  :lesson,
              inverse_of: :lesson_assignment
end
