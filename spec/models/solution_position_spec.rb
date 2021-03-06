require 'spec_helper'

describe SolutionPosition do
  it { should validate_presence_of(:start_position) }
  it { should validate_presence_of(:end_position) }
  it { should validate_presence_of(:card) }
  it { should allow_value(0).for(:start_position) }
  it { should_not allow_value(-1).for(:start_position) }

  it { should belong_to(:card) }

  context 'with a valid start and end position' do
    let(:solution_position) { FactoryGirl.build(:solution_position) }

    it 'is valid when start is greater than end' do
      expect(solution_position).to be_valid
    end

    let(:solution_position) { FactoryGirl.build(:solution_position, end_position: 1) }

    it 'is valid when start is greater than end' do
      expect(solution_position).to be_valid
    end
  end

  context 'with an invalid start and end position' do
    let(:solution_position) { FactoryGirl.build(:solution_position, start_position: 3) }

    it 'is is invalid when start is greater than end position' do
      expect(solution_position).to be_invalid
    end
  end

  describe "has a response checker" do
    let(:correct_answer)  { {start: '0', end: '1'} }
    let(:solution)        { FactoryGirl.create(:solution_position,
                            start_position: correct_answer[:start],
                            end_position: correct_answer[:end]) }

    it "returns true if the response is correct" do
      correct_response = {position: correct_answer[:start]}
      expect(solution.response_match?(correct_response)).to be_true
      correct_response = {position: correct_answer[:end]}
      expect(solution.response_match?(correct_response)).to be_true
    end

    it "returns false if the response is incorrect" do
      incorrect_response = {position: 9000}
      expect(solution.response_match?(incorrect_response)).to be_false
    end
  end
end
