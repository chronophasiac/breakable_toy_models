require 'spec_helper'

describe LessonAssignment do
  it { should validate_presence_of(:position) }
  it { should validate_presence_of(:lesson) }
  it { should validate_presence_of(:assignment) }

  it { should belong_to(:lesson) }
  it { should belong_to(:assignment) }
end
