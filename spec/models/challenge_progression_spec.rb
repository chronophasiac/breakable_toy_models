require 'spec_helper'

describe ChallengeProgression do
  it { should validate_presence_of(:score) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:challenge) }

  it { should allow_value(0).for(:score) }
  it { should allow_value(1).for(:score) }
  it { should_not allow_value(-1).for(:score) }

  it { should belong_to(:user) }
  it { should belong_to(:challenge) }
end
