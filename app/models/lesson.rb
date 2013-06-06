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
end
