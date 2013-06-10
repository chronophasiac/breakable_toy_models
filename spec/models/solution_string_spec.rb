require 'spec_helper'

describe SolutionString do
  it { should validate_presence_of(:regex) }
  it { should validate_presence_of(:card) }

  it { should belong_to(:card) }
end
