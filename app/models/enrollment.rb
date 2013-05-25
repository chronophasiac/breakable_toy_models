class Enrollment < ActiveRecord::Base
  attr_accessible :last_accessed_at, :lesson_id, :user_id
end
