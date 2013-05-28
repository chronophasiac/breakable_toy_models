require 'spec_helper'

describe Answer do
  it { should validate_presence_of(:start_position) }
  it { should validate_presence_of(:end_position) }
  it { should validate_presence_of(:card_id) }
  it { should validate_presence_of(:card) }

  it { should belong_to(:card) }

  context 'with a valid start and end position' do
    let(:answer) { FactoryGirl.build(:answer) }

    it 'is valid' do
      expect(answer).to be_valid
    end
  end
end
