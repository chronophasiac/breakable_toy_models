require 'spec_helper'

describe ChallengeDeck do
  it { should validate_presence_of(:challenge) }
  it { should validate_presence_of(:card) }

  it { should belong_to(:card) }
  it { should belong_to(:challenge) }
end
