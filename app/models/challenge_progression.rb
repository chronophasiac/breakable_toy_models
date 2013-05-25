class ChallengeProgression < ActiveRecord::Base
  attr_accessible :challenge_id, :score, :user_id

  validates_presence_of :user_id
  validates_presence_of :challenge_id
  validates_presence_of :score

  belongs_to  :user,
              inverse_of: :challenge_progression

  belongs_to  :challenge,
              inverse_of: :challenge_progression
end
