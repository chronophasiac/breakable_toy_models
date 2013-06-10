require 'spec_helper'

describe SolutionIndex do
  it { should validate_presence_of(:start_index) }
  it { should validate_presence_of(:end_index) }
  it { should validate_presence_of(:card) }

  it { should belong_to(:card) }

  context 'with a valid start and end position' do
    let(:solution_index) { FactoryGirl.build(:solution_index) }

    it 'is valid when start is greater than end' do
      expect(solution_index).to be_valid
    end

    let(:solution_index) { FactoryGirl.build(:solution_index, end_index: 1) }

    it 'is valid when start is greater than end' do
      expect(solution_index).to be_valid
    end
  end

  context 'with an invalid start and end position' do
    let(:solution_index) { FactoryGirl.build(:solution_index, start_index: 3) }

    it 'is is invalid when start is greater than end position' do
      expect(solution_index).to be_invalid
    end
  end
end
