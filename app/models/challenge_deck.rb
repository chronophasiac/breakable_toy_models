class ChallengeDeck < ActiveRecord::Base
  attr_accessible :card_id, :challenge_id

  validates_presence_of :card_id
  validates_presence_of :challenge_id

  belongs_to  :card,
              inverse_of: :challenge_deck

  belongs_to  :challenge,
              inverse_of: :challenge_deck
end
