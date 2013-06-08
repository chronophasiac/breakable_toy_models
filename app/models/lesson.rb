# == Schema Information
#
# Table name: lessons
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  summary    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Lesson < ActiveRecord::Base
  attr_accessible :summary, :title

  validates_presence_of :title
  validates_presence_of :summary

  scope :ascending_by_title, order("title ASC")

  has_many  :syllabuses,
            inverse_of: :lesson,
            dependent: :destroy

  has_many  :assignments,
            through: :syllabuses,
            inverse_of: :lessons

  has_many  :enrollments,
            inverse_of: :lesson

  has_many  :users,
            through: :enrollments,
            inverse_of: :lessons

  has_many  :challenges,
            inverse_of: :lesson,
            dependent: :destroy

  def curriculum
    lesson = Lesson.includes(:challenges, :assignments).find(self.id)
    curriculum = {}
    lesson.syllabuses.each do |syllabus|
      curriculum[syllabus.position] = syllabus.assignment
    end

    lesson.challenges.each do |challenge|
      curriculum[challenge.position] = challenge
    end

    curriculum = curriculum.sort_by { |key| key }
    c = []
    curriculum.each do |item|
      c << item[1]
    end
    c
  end
end
