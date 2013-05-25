require 'spec_helper'

describe User do
  it { should validate_presence_of(:role) }
  it { should validate_uniqueness_of(:username) }

  it { should allow_value("student").for(:role) }
  it { should allow_value("admin").for(:role) }
  it { should_not allow_value("foobar").for(:role) }

  it { should have_many(:card_submissions) }
  it { should have_many(:cards) }

  it { should have_many(:courseworks) }
  it { should have_many(:assignments) }

  it { should have_many(:assignment_ratings) }

  it { should have_many(:enrollments) }
  it { should have_many(:lessons) }

  it { should have_many(:challenge_progressions) }
  it { should have_many(:challenges) }
end
