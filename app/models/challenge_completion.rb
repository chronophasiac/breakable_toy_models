class ChallengeCompletion < ActiveRecord::Base
  belongs_to  :user,
              inverse_of: :challenge_completions
  belongs_to  :challenge,
              inverse_of: :challenge_completions

  validates_presence_of :score, :user, :challenge

  validates :score, numericality: { only_integer: true, greater_than_or_equal_to: 0}

  attr_accessible :challenge_id, :score
end
