require 'spec_helper'

describe Challenge do
  it { should validate_presence_of(:lesson_id) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:position) }
  it { should validate_presence_of(:lesson) }

  it { should have_many(:challenge_progressions) }
  it { should have_many(:users) }

  it { should belong_to(:lesson) }

  it { should have_many(:challenge_decks) }
  it { should have_many(:cards) }
  
  it { should allow_value(0).for(:position) }
  it { should allow_value(1).for(:position) }
  it { should_not allow_value(-1).for(:position) }
end
