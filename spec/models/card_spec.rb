require 'spec_helper'

describe Card do
  it { should have_many(:solution_positions).dependent(:destroy) }
  it { should have_many(:solution_strings).dependent(:destroy) }
  it { should have_many(:card_submissions).dependent(:destroy) }
  it { should have_many(:users) }
  it { should have_many(:card_submission_logs) }
  it { should have_many(:card_prerequisites).dependent(:destroy) }
  it { should have_many(:assignments) }
  it { should have_many(:challenge_decks) }
  it { should have_many(:challenges) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:instructions) }
  it { should validate_presence_of(:problem) }
  it { should validate_presence_of(:solution_type) }

  it { should allow_value("string").for(:solution_type) }
  it { should allow_value("position").for(:solution_type) }
  it { should_not allow_value("invalid").for(:solution_type) }

  context 'with valid attributes' do
    let(:card) { FactoryGirl.create(:card_string_solution) }

    it 'is valid' do
      expect(card).to be_valid
    end
  end

  context 'with a string solution' do
    let(:card)            { FactoryGirl.create(:card_string_solution) }
    let(:solution_string) { card.solution_strings.first }
    let(:correct_answer)  { "this is correct" }

    before(:each) do
      solution_string.regex = "^#{correct_answer}$"
      solution_string.save!
    end

    it 'has a canonical solution' do
      expect(card.canonical_solution).to eql(correct_answer)
    end

    it 'has a canonical solution without backslashes' do
      backslashed_solution = 'test\ string'
      unbackslashed_solution = 'test string'
      solution_string.regex = "^#{backslashed_solution}$"
      solution_string.save!
      expect(card.canonical_solution).to eql(unbackslashed_solution)
    end

    it 'returns an empty string if it does not' do
      solution_string.canonical = false
      solution_string.save!
      expect(card.canonical_solution).to eql("")
    end
  end

  describe 'has a kind' do
    let(:card_string)   { FactoryGirl.create(:card_string_solution) }
    let(:card_position) { FactoryGirl.create(:card_position_solution) }

    it 'returns "type" if it has a string solution' do
      expect(card_string.kind).to eql("type")
    end

    it 'returns "click" if it has a string solution' do
      expect(card_position.kind).to eql("click")
    end
  end

  describe 'tests a response' do
    context 'with an explicit string response' do
      let(:correct_answer)  { "this is correct" }
      let(:solution)        { FactoryGirl.create(:solution_string,
                              regex: "^#{correct_answer}$") }
      let(:card)            { solution.card }

      it 'returns true if the response is correct' do
        expect(card.correct_answer?(correct_answer)).to be_true
      end

      it 'returns false if the response is incorrect' do
        expect(card.correct_answer?("not correct")).to be_false
      end

      it 'returns false if the response is nil' do
        expect(card.correct_answer?(nil)).to be_false
      end
    end

    context 'with an array of indices' do
      let(:correct_answer)  { {start: '0', end: '1'} }
      let(:solution)        { FactoryGirl.create(:solution_position,
                              start_position: correct_answer[:start],
                              end_position: correct_answer[:end]) }
      let(:card)            { solution.card }

      context 'with a single response' do
        it 'returns true if the response is in the range of solutions' do
          correct_response = [{position: correct_answer[:start]}]
          expect(card.correct_answer?(correct_response)).to be_true
          correct_response = [{position: correct_answer[:end]}]
          expect(card.correct_answer?(correct_response)).to be_true
        end

        it 'returns false if the response is outside the range of solutions' do
          incorrect_response = [{position: 9000}]
          expect(card.correct_answer?(incorrect_response)).to be_false
        end
      end

      context 'with many responses' do
        it 'returns true if all the responses are in the range of solutions' do
          correct_responses = [ {position: correct_answer[:start]},
                                {position: correct_answer[:end]}]
          expect(card.correct_answer?(correct_responses)).to be_true
          correct_responses = [ {position: correct_answer[:end]},
                                {position: correct_answer[:start]}]
          expect(card.correct_answer?(correct_responses)).to be_true
        end

        it 'returns false if one of the responses are outside the range of solutions' do
          incorrect_responses = [ {position: correct_answer[:end]},
                                  {position: 9000}]
          expect(card.correct_answer?(incorrect_responses)).to be_false
          incorrect_responses = [ {position: 9000},
                                  {position: correct_answer[:end]}]
          expect(card.correct_answer?(incorrect_responses)).to be_false
        end

        it 'returns false if all of the responses are outside the range of solutions' do
          incorrect_responses = [ {position: 9001},
                                  {position: 9000}]
          expect(card.correct_answer?(incorrect_responses)).to be_false
        end
      end
    end
  end

  describe 'has a tokenized html array' do
    let(:snippet) { "Test for snippets" }
    let(:card)    { FactoryGirl.create(:card_position_solution, snippet: snippet) }

    it 'returns an array of hashes' do
      expect(card.tokenized_snippet).to be_an(Array)
      expect(card.tokenized_snippet[0]).to be_a(Hash)
    end

    it 'returns a tokenized array' do
      expect(card.tokenized_snippet[0][:text]).to include("Test")
      expect(card.tokenized_snippet[0][:text]).to_not include("for")
    end

    describe 'with the solutions indicated' do
      let(:solution) { card.solution_positions.first }

      it 'returns true for correct positions' do
        expect(card.tokenized_snippet[solution.start_position][:solution]).to be_true
      end

      it 'returns false for incorrect positions' do
        expect(card.tokenized_snippet[solution.end_position + 1][:solution]).to be_false
      end
    end
  end


end
