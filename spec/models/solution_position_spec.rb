# == Schema Information
#
# Table name: solution_positions
#
#  id             :integer          not null, primary key
#  start_position :integer          not null
#  end_position   :integer          not null
#  card_id        :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

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
end
