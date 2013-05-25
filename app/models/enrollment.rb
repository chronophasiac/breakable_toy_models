class Enrollment < ActiveRecord::Base
  attr_accessible :last_accessed_at, :lesson_id, :user_id

  validates_presence_of :user_id
  validates_presence_of :lesson_id
  validates_presence_of :last_accessed_at

  belongs_to  :user,
              inverse_of: :enrollment

  belongs_to  :lesson,
              inverse_of: :enrollment
end
