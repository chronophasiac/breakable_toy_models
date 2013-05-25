require 'spec_helper'

describe Lesson do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:summary) }

  it { should have_many(:lesson_assignments) }
  it { should have_many(:assignments) }

  it { should have_many(:enrollments) }
  it { should have_many(:users) }

  it { should have_many(:challenges) }
end
