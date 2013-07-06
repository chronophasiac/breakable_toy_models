class AssignmentRating < ActiveRecord::Base
  belongs_to  :user,
              inverse_of: :assignment_ratings

  belongs_to  :assignment,
              inverse_of: :assignment_ratings

  validates_presence_of :helpful, :user, :assignment

  attr_accessible :helpful
end
