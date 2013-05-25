require 'spec_helper'

describe CardPrerequisite do
  it { should validate_presence_of(:card_id) }
  it { should validate_presence_of(:assignment_id) }
  it { should validate_presence_of(:card) }
  it { should validate_presence_of(:assignment) }

  it { should belong_to(:card) }
  it { should belong_to(:assignment) }
end
