# == Schema Information
#
# Table name: challenges
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Challenge do
  it { should validate_presence_of(:title) }

  it { should have_many(:challenge_progressions).dependent(:destroy) }
  it { should have_many(:users) }
  it { should have_many(:activities).dependent(:destroy) }
  it { should have_many(:lessons) }
  it { should have_many(:challenge_decks).dependent(:destroy) }
  it { should have_many(:cards) }
end
