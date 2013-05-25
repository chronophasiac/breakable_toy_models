require 'spec_helper'

describe CardSubmission do
  it { should belong_to(:card) }
  it { should belong_to(:user) }
end
