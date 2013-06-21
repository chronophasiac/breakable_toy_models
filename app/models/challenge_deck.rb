# == Schema Information
#
# Table name: challenge_decks
#
#  id           :integer          not null, primary key
#  challenge_id :integer          not null
#  card_id      :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class ChallengeDeck < ActiveRecord::Base
  belongs_to  :card,
              inverse_of: :challenge_decks
  belongs_to  :challenge,
              inverse_of: :challenge_decks

  validates_presence_of :card, :challenge
end
