require 'spec_helper'

describe CardSubmission do
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:card) }

  it { should belong_to(:user) }
  it { should belong_to(:card) }
  it { should have_many(:card_submission_logs) }
end
