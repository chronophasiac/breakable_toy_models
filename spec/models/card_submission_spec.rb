require 'spec_helper'

describe CardSubmission do
  it { should belong_to(:user) }
  it { should belong_to(:card) }
  it { should have_many(:card_submission_logs).dependent(:destroy) }

  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:card) }

  describe 'updates submissions based on new submission logs' do
    let(:user) { FactoryGirl.create(:user) }
    let(:card) { FactoryGirl.create(:card_string_solution) }
    let(:submission) { FactoryGirl.create(:card_submission, user: user, card: card) }

    it "creates a new submission if one does not exist" do
      user_submissions = user.cards.length
      CardSubmission.update_submission(user, card)
      user.reload
      expect(user.cards.length).to eql(user_submissions + 1)
    end

    it "updates an existing submission" do
      past = 5.minutes.ago
      submission.updated_at = past
      submission.save!
      CardSubmission.update_submission(user, card)
      submission.reload
      expect(submission.updated_at).to be >(past)
    end

  end
end
