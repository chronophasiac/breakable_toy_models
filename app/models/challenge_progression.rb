class ChallengeProgression < ActiveRecord::Base
  attr_accessible :challenge_id, :score, :user_id

  validates_presence_of :user_id
  validates_presence_of :challenge_id
  validates_presence_of :score
  validates_presence_of :user
  validates_presence_of :challenge

  validates :score, numericality: { only_integer: true, greater_than_or_equal_to: 0}

  belongs_to  :user,
              inverse_of: :challenge_progressions

  belongs_to  :challenge,
              inverse_of: :challenge_progressions
end
