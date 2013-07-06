require 'spec_helper'

describe Sm2Instance do
  it { should belong_to(:card_submission) }

  describe "has spaced repetition methods" do
    let(:sm2) { FactoryGirl.create(:sm2_instance) }

    it "returns a next repetition date" do
      sm2.process(4)
      expect(sm2.next_repetition).to be_a(Date)
    end

    it "returns a date in the future" do
      sm2.process(4)
      expect(sm2.next_repetition).to be >(Date.today)
    end
  end

end
