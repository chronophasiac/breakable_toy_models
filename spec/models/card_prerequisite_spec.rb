require 'spec_helper'

describe CardPrerequisite do
  it { should belong_to(:card) }
  it { should belong_to(:assignment) }
end
