class Coursework < ActiveRecord::Base
  belongs_to  :user,
              inverse_of: :courseworks
  belongs_to  :assignment,
              inverse_of: :courseworks
  belongs_to  :lesson,
              inverse_of: :courseworks

  validates_presence_of :user, :assignment, :lesson

  validates_uniqueness_of :assignment_id, scope: :user_id

  attr_accessible :assignment_id, :completed, :lesson_id
end
