class Challenge < ActiveRecord::Base
  has_many  :challenge_completions,
            inverse_of: :challenge,
            dependent: :destroy
  has_many  :users,
            through: :challenge_completions,
            inverse_of: :challenges
  has_many  :activities,
            as: :completable,
            dependent: :destroy
  has_many  :lessons,
            through: :activities
  has_many  :challenge_decks,
            inverse_of: :challenge,
            dependent: :destroy
  has_many  :cards,
            through: :challenge_decks,
            inverse_of: :challenges

  validates_presence_of :title
  
  attr_accessible :title
end
