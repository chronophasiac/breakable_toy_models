# == Schema Information
#
# Table name: challenge_progressions
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  challenge_id :integer
#  score        :integer          default(0), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

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
