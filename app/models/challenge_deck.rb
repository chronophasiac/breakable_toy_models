class ChallengeDeck < ActiveRecord::Base
  attr_accessible :card_id, :challenge_id

  belongs_to :card
  belongs_to :challenge
end
