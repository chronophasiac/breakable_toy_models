require 'spec_helper'

describe MyDeck do
  let(:user)        { FactoryGirl.create(:user) }
  let!(:submission)  { FactoryGirl.create(:card_submission, user: user) }
  let(:card)        { submission.card }
  let!(:log)         { FactoryGirl.create(:card_submission_log, card_submission: submission) }
  let(:deck)        { MyDeck.new(user) }

  describe "returning a deck of cards" do
    it "is an array" do
      expect(deck.cards).to be_an(Array)
    end

    it "has cards associated with a user" do
      expect(deck.cards.first).to eql(card)
    end
  end

end
