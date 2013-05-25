require 'spec_helper'

describe Answer do
  it { should validate_presence_of(:start_position) }
  it { should validate_presence_of(:end_position) }

  it { should belong_to(:card) }
end
