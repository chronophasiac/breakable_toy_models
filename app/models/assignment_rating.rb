class AssignmentRating < ActiveRecord::Base
  attr_accessible :assignment_id, :helpful, :user_id

  validates_presence_of :user_id
  validates_presence_of :assignment_id
  validates_presence_of :helpful
  validates_presence_of :user
  validates_presence_of :assignment

  belongs_to  :user,
              inverse_of: :assignment_ratings

  belongs_to  :assignment,
              inverse_of: :assignment_ratings
end
