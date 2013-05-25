class Lesson < ActiveRecord::Base
  attr_accessible :summary, :title

  validates_presence_of :title
  validates_presence_of :summary

  has_many  :lesson_assignments,
            inverse_of: :lesson,
            dependent: :destroy

  has_many  :assignments,
            through: :lesson_assignments,
            inverse_of: :lessons

  has_many  :enrollments,
            inverse_of: :lesson

  has_many  :users,
            through: :enrollments,
            inverse_of: :lessons

  has_many  :challenges,
            inverse_of: :lesson,
            dependent: :destroy
end
