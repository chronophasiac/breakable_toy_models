class Syllabus < ActiveRecord::Base
  attr_accessible :assignment_id, :lesson_id, :position

  validates_presence_of :position
  validates_presence_of :lesson
  validates_presence_of :assignment

  belongs_to  :assignment,
              inverse_of: :syllabuses

  belongs_to  :lesson,
              inverse_of: :syllabuses
end
