class AssignmentRating < ActiveRecord::Base
  attr_accessible :assignment_id, :helpful, :user_id
end
