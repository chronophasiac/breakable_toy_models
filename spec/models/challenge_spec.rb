require 'spec_helper'

describe Challenge do
  it { should validate_presence_of(:lesson_id) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:position) }

  it { should have_many(:challenge_progressions) }
  it { should have_many(:users) }

  it { should belong_to(:lesson) }

  it { should have_many(:challenge_decks) }
  it { should have_many(:cards) }
end
