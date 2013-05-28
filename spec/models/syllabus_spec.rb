require 'spec_helper'

describe Syllabus do
  it { should validate_presence_of(:position) }
  it { should validate_presence_of(:lesson) }
  it { should validate_presence_of(:assignment) }

  it { should belong_to(:lesson) }
  it { should belong_to(:assignment) }


  it { should allow_value(0).for(:position) }
  it { should allow_value(1).for(:position) }
  it { should_not allow_value(-1).for(:position) }
end
