class ChallengeDeck < ActiveRecord::Base
  belongs_to  :card,
              inverse_of: :challenge_decks
  belongs_to  :challenge,
              inverse_of: :challenge_decks

  validates_presence_of :card, :challenge
end
