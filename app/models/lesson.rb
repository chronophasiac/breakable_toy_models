class Lesson < ActiveRecord::Base
  has_many  :activities,
            inverse_of: :lesson,
            dependent: :destroy
  has_many  :enrollments,
            inverse_of: :lesson,
            dependent: :destroy
  has_many  :courseworks,
            inverse_of: :lesson,
            dependent: :destroy
  has_many  :users,
            through: :enrollments,
            inverse_of: :lessons

  validates_presence_of :title, :summary

  attr_accessible :summary, :title

  class << self
    def ascending_by_title
      order("title ASC")
    end
  end
end
