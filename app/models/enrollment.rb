class Enrollment < ActiveRecord::Base
  attr_accessible :last_accessed_at, :lesson_id, :user_id

  validates_presence_of :user_id
  validates_presence_of :lesson_id
  validates_presence_of :last_accessed_at
  validates_presence_of :user
  validates_presence_of :lesson

  validates_datetime :last_accessed_at, on_or_before: lambda { DateTime.now }

  belongs_to  :user,
              inverse_of: :enrollments

  belongs_to  :lesson,
              inverse_of: :enrollments
end
