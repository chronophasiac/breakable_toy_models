class ChallengeDeck < ActiveRecord::Base
  attr_accessible :card_id, :challenge_id

  validates_presence_of :card_id
  validates_presence_of :challenge_id
  validates_presence_of :card
  validates_presence_of :challenge

  belongs_to  :card,
              inverse_of: :challenge_decks

  belongs_to  :challenge,
              inverse_of: :challenge_decks
end
