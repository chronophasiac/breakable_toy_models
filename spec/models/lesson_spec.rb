require 'spec_helper'

describe Lesson do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:summary) }

  it { should have_many(:enrollments).dependent(:destroy) }
  it { should have_many(:users) }
  it { should have_many(:courseworks).dependent(:destroy) }
  it { should have_many(:activities) }
end
