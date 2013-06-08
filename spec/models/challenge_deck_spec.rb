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

require 'spec_helper'

describe ChallengeDeck do
  it { should validate_presence_of(:challenge) }
  it { should validate_presence_of(:card) }

  it { should belong_to(:card) }
  it { should belong_to(:challenge) }
end
