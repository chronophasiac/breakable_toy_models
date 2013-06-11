# == Schema Information
#
# Table name: enrollments
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  lesson_id        :integer          not null
#  last_accessed_at :datetime         not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Enrollment < ActiveRecord::Base
  belongs_to  :user,
              inverse_of: :enrollments
  belongs_to  :lesson,
              inverse_of: :enrollments

  validates_presence_of :last_accessed_at, :user, :lesson

  validates_datetime :last_accessed_at, on_or_before: lambda { DateTime.now }

  validates_uniqueness_of :lesson_id, scope: :user_id

  attr_accessible :last_accessed_at, :lesson_id, :user_id
end
