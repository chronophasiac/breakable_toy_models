require 'spec_helper'

describe Dashboard do
  let(:user)      { FactoryGirl.create(:user) }
  let(:dashboard) { Dashboard.new(user) }

  describe "returning a user's recently completed challenges" do
    let!(:challenge_completion) { FactoryGirl.create(:challenge_completion, user: user) }
    let(:challenge) { challenge_completion.challenge }

    it "is a collection of AREL objects" do
      expect(dashboard.completed_challenges).to be_an(ActiveRecord::Relation)
    end

    it "contains a completed challenge" do
      expect(dashboard.completed_challenges.first.challenge).to eql(challenge)
    end

    it "contains no more than 5 challenges" do
      15.times do
        FactoryGirl.create(:challenge_completion, user: user)
      end
      expect(dashboard.completed_challenges.length).to eql(5)
    end

    it "contains the most recent challenges" do
      15.times do
        FactoryGirl.create(:challenge_completion, user: user, updated_at: 5.minutes.ago)
      end
      expect(dashboard.completed_challenges.first.challenge).to eql(challenge)
    end

    it "has a score" do
      expect(dashboard.completed_challenges.first.score).to eql(challenge_completion.score)
    end
  end

  describe "returning a user's in progress lessons" do
    let!(:enrollment) { FactoryGirl.create(:enrollment, user: user) }
    let!(:activity)   { FactoryGirl.create(:activity, lesson: enrollment.lesson) }

    it "contains a lesson in progress" do
      expect(dashboard.lessons_in_progress.first).to eql(enrollment.lesson)
    end

    it "returns no more than 5 lessons" do
      15.times do
        additional_enrollment = FactoryGirl.create(:enrollment, user: user)
        FactoryGirl.create(:activity, lesson: additional_enrollment.lesson)
      end
      expect(dashboard.lessons_in_progress.length).to eql(5)
    end
  end
end
