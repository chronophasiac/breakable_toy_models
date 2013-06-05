# == Schema Information
#
# Table name: answers
#
#  id             :integer          not null, primary key
#  start_position :integer          not null
#  end_position   :integer          not null
#  card_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

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

    let(:answer) { FactoryGirl.build(:answer, end_position: 1) }

    it 'is valid when start is greater than end' do
      expect(answer).to be_valid
    end
  end

  context 'with an invalid start and end position' do
    let(:answer) { FactoryGirl.build(:answer, start_position: 3) }

    it 'is is invalid when start is greater than end position' do
      expect(answer).to be_invalid
    end
  end
end
