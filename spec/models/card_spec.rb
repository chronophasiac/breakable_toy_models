# == Schema Information
#
# Table name: cards
#
#  id            :integer          not null, primary key
#  title         :string(255)      not null
#  instructions  :text             not null
#  problem       :text             not null
#  solution_type :string(255)      not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

describe Card do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:instructions) }
  it { should validate_presence_of(:problem) }
  it { should validate_presence_of(:assignments) }
  it { should validate_presence_of(:solution_type) }

  it { should have_many(:solution_indices) }
  it { should have_many(:solution_strings) }
  it { should have_many(:card_submissions) }
  it { should have_many(:users) }
  it { should have_many(:card_prerequisites) }
  it { should have_many(:assignments) }
  it { should have_many(:challenge_decks) }
  it { should have_many(:challenges) }

  it { should allow_value("string").for(:solution_type) }
  it { should allow_value("index").for(:solution_type) }
  it { should_not allow_value("invalid").for(:solution_type) }

  context 'with valid attributes' do
    let(:card) { FactoryGirl.create(:card) }

    it 'is valid' do
      expect(card).to be_valid
    end
  end
end
