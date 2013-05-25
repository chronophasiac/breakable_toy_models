require 'spec_helper'

describe ChallengeDeck do
  it { should validate_presence_of(:challenge_id) }
  it { should validate_presence_of(:card_id) }

  it { should belong_to(:card) }
  it { should belong_to(:challenge) }
end
