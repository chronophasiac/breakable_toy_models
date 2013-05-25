require 'spec_helper'

describe CardSubmission do
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:card_id) }

  it { should belong_to(:user) }
  it { should belong_to(:card) }
end
