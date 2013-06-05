# == Schema Information
#
# Table name: challenge_decks
#
#  id           :integer          not null, primary key
#  challenge_id :integer
#  card_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class ChallengeDeck < ActiveRecord::Base
  attr_accessible :card_id, :challenge_id

  validates_presence_of :card
  validates_presence_of :challenge

  belongs_to  :card,
              inverse_of: :challenge_decks

  belongs_to  :challenge,
              inverse_of: :challenge_decks
end
