# == Schema Information
#
# Table name: assignment_ratings
#
#  id            :integer          not null, primary key
#  user_id       :integer          not null
#  assignment_id :integer          not null
#  helpful       :boolean          default(FALSE), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class AssignmentRating < ActiveRecord::Base
  belongs_to  :user,
              inverse_of: :assignment_ratings

  belongs_to  :assignment,
              inverse_of: :assignment_ratings

  validates_presence_of :helpful, :user, :assignment

  attr_accessible :assignment_id, :helpful, :user_id
end
