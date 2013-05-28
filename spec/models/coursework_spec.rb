require 'spec_helper'

describe Coursework do
  it { should validate_presence_of(:completed) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:assignment) }
  
  it { should belong_to(:user) }
  it { should belong_to(:assignment) }
end
