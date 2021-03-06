require 'spec_helper'

describe CardSubmissionLog do
  it { should belong_to(:card_submission) }
  it { should have_one(:user) }
  it { should have_one(:card) }

  it { should validate_presence_of(:time_taken) }
  it { should validate_presence_of(:card_submission) }

  it { should allow_value(0).for(:rated_difficulty) }
  it { should allow_value(3).for(:rated_difficulty) }
  it { should allow_value(5).for(:rated_difficulty) }
  it { should_not allow_value(-1).for(:rated_difficulty) }
  it { should_not allow_value(6).for(:rated_difficulty) }
  it { should_not allow_value(9000).for(:rated_difficulty) }

  it { should allow_value(30).for(:time_taken) }
  it { should allow_value(0).for(:time_taken) }
  it { should_not allow_value(-30).for(:time_taken) }

  context 'with valid attributes' do
    let(:card_submission_log) { FactoryGirl.build(:card_submission_log) }

    it 'is valid' do
      expect(card_submission_log).to be_valid
    end
  end
end
