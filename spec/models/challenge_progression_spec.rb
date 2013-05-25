require 'spec_helper'

describe ChallengeProgression do
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:challenge_id) }
  it { should validate_presence_of(:score) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:challenge) }

  it { should belong_to(:user) }
  it { should belong_to(:challenge) }
end
