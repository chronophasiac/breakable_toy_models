require 'spec_helper'

describe Assignment do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:instructions) }
  it { should validate_presence_of(:assignment_type) }

  it { should allow_value("http://google.com").for(:url) }
  it { should_not allow_value("invalid url").for(:url) }

  it { should allow_value("video").for(:assignment_type) }
  it { should allow_value("text").for(:assignment_type) }
  it { should allow_value("audio").for(:assignment_type) }
  it { should_not allow_value("foo").for(:assignment_type) }

  it { should have_many(:card_prerequisites) }
  it { should have_many(:cards) }

  it { should have_many(:courseworks) }
  it { should have_many(:users) }

  it { should have_many(:assignment_ratings) }
  
  it { should have_many(:lesson_assignments) }
  it { should have_many(:lessons) }
end
