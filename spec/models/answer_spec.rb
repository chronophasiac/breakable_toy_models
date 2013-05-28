require 'spec_helper'

describe Answer do
  it { should validate_presence_of(:start_position) }
  it { should validate_presence_of(:end_position) }
  it { should validate_presence_of(:card) }

  it { should belong_to(:card) }

  context 'with a valid start and end position' do
    let(:answer) { FactoryGirl.build(:answer) }

    it 'is valid when start is greater than end' do
      expect(answer).to be_valid
    end

    let(:answer) { FactoryGirl.build(:answer, :start_equals_end) }

    it 'is valid when start is greater than end' do
      expect(answer).to be_valid
    end
  end

  context 'with an invalid start and end position' do
    let(:answer) { FactoryGirl.build(:answer, :start_greater_than_end) }

    it 'is is invalid when start is greater than end position' do
      expect(answer).to be_invalid
    end
  end
end
