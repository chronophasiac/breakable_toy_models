# == Schema Information
#
# Table name: challenge_progressions
#
#  id           :integer          not null, primary key
#  user_id      :integer          not null
#  challenge_id :integer          not null
#  score        :integer          default(0), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class ChallengeProgression < ActiveRecord::Base
  attr_accessible :challenge_id, :score, :user_id

  validates_presence_of :score
  validates_presence_of :user
  validates_presence_of :challenge

  validates :score, numericality: { only_integer: true, greater_than_or_equal_to: 0}

  belongs_to  :user,
              inverse_of: :challenge_progressions

  belongs_to  :challenge,
              inverse_of: :challenge_progressions
end
