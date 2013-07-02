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

  it { should have_many(:solution_positions).dependent(:destroy) }
  it { should have_many(:solution_strings).dependent(:destroy) }
  it { should have_many(:card_submissions).dependent(:destroy) }
  it { should have_many(:users) }
  it { should have_many(:card_prerequisites).dependent(:destroy) }
  it { should have_many(:assignments) }
  it { should have_many(:challenge_decks) }
  it { should have_many(:challenges) }

  it { should allow_value("string").for(:solution_type) }
  it { should allow_value("position").for(:solution_type) }
  it { should_not allow_value("invalid").for(:solution_type) }

  context 'with valid attributes' do
    let(:card) { FactoryGirl.create(:card_string_solution) }

    it 'is valid' do
      expect(card).to be_valid
    end
  end

  describe 'has a correct answer' do
    context 'with an explicit string response' do
      let(:correct_answer)  { "this is correct" }
      let(:answer)          { FactoryGirl.create(:solution_string, regex: "^#{correct_answer}$") }
      let(:card)            { answer.card }

      it 'returns true if the answer is correct' do
        expect(card.correct_answer?(correct_answer)).to be_true
      end

      it 'returns false if the answer is incorrect' do
        expect(card.correct_answer?("not correct")).to be_false
      end
    end
  end

end
