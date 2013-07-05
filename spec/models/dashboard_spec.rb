require 'spec_helper'

describe Dashboard do
  let(:user)      { FactoryGirl.create(:user) }
  let(:dashboard) { Dashboard.new(user) }

  describe "returning a user's recently completed challenges" do
    let!(:challenge_progression) { FactoryGirl.create(:challenge_progression, user: user) }
    let(:challenge) { challenge_progression.challenge }

    it "is a collection of AREL objects" do
      expect(dashboard.completed_challenges).to be_an(ActiveRecord::Relation)
    end

    it "contains a completed challenge" do
      expect(dashboard.completed_challenges.first.challenge).to eql(challenge)
    end

    it "contains no more than 10 challenges" do
      15.times do
        FactoryGirl.create(:challenge_progression, user: user)
      end
      expect(dashboard.completed_challenges.length).to eql(10)
    end

    it "contains the most recent challenges" do
      15.times do
        FactoryGirl.create(:challenge_progression, user: user, updated_at: 5.minutes.ago)
      end
      expect(dashboard.completed_challenges.first.challenge).to eql(challenge)
    end

    it "has a score" do
      expect(dashboard.completed_challenges.first.score).to eql(challenge_progression.score)
    end
  end
end
