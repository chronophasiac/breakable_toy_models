class ChallengeProgression < ActiveRecord::Base
  attr_accessible :challenge_id, :score, :user_id

  validates_presence_of :user_id
  validates_presence_of :challenge_id
  validates_presence_of :score
  validates_presence_of :user
  validates_presence_of :challenge

  belongs_to  :user,
              inverse_of: :challenge_progressions

  belongs_to  :challenge,
              inverse_of: :challenge_progressions
end
