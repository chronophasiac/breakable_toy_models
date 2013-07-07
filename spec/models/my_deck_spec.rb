require 'spec_helper'

describe MyDeck do
  let(:user)        { FactoryGirl.create(:user) }
  let(:deck)        { MyDeck.new(user) }

  describe "returning a deck of cards" do
    let!(:submission)  { FactoryGirl.create(:card_submission, user: user) }
    let(:card)        { submission.card }

    it "is an array" do
      expect(deck.cards).to be_an(Array)
    end

    it "has cards associated with a user" do
      expect(deck.cards.first).to eql(card)
    end
  end

  describe "sorted by next repetition" do
    let(:submission1)  { FactoryGirl.create(:card_submission, user: user) }
    let(:submission2)  { FactoryGirl.create(:card_submission, user: user) }
    let!(:correct_submission)     { FactoryGirl.create(:card_submission_log,
                                    card_submission: submission1, correct: true) }
    let!(:incorrect_submission)  { FactoryGirl.create(:card_submission_log,
                                    card_submission: submission2, correct: false) }
    it "has incorrectly answered cards first" do
      expect(deck.cards.first).to eql(incorrect_submission.card)
    end
  end

end
