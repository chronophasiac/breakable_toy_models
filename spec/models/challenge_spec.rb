require 'spec_helper'

describe Challenge do
  it { should validate_presence_of(:title) }

  it { should have_many(:challenge_completions).dependent(:destroy) }
  it { should have_many(:users) }
  it { should have_many(:activities).dependent(:destroy) }
  it { should have_many(:lessons) }
  it { should have_many(:challenge_decks).dependent(:destroy) }
  it { should have_many(:cards) }
end
