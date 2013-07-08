require 'spec_helper'

describe SolutionString do
  it { should validate_presence_of(:regex) }
  it { should validate_presence_of(:card) }
  let(:valid_solution_string) { FactoryGirl.build(:solution_string) }

  it "is valid with valid attributes" do
    expect(valid_solution_string).to be_valid
  end

  it "is invalid without regex" do
    invalid_solution_string = valid_solution_string.dup
    invalid_solution_string.regex = nil
    expect(invalid_solution_string).to_not be_valid
  end

  it "is invalid without card" do
    invalid_solution_string = valid_solution_string.dup
    invalid_solution_string.card = nil
    expect(invalid_solution_string).to_not be_valid
  end

  it { should belong_to(:card) }

  describe "has a response checker" do

    context "with an explicit regex" do
      let(:correct_answer)  { "this is correct" }
      let(:solution)        { FactoryGirl.create(:solution_string, regex: "^#{correct_answer}$") }

      it "returns true if the response is correct" do
        expect(solution.correct_response?(correct_answer)).to be_true
      end

      it "is case insensitive" do
        expect(solution.correct_response?(correct_answer.upcase)).to be_true
        solution.regex.upcase!
        expect(solution.correct_response?(correct_answer)).to be_true
      end

      it "returns false if the response does not include the correct answer" do
        expect(solution.correct_response?("this isn't correct")).to be_false
      end

      it "returns false if the response is incorrect and includes the correct answer" do
        expect(solution.correct_response?("this is correct NOT")).to be_false
      end

      it "returns false if the response includes part of the correct answer" do
        expect(solution.correct_response?("this is")).to be_false
      end

      it "returns false if the response is nil" do
        expect(solution.correct_response?(nil)).to be_false
      end
    end

    context "with a fuzzy regex" do
      let(:correct_answer)            { "plural" }
      let(:correct_answer_pluralized) { "plurals" }
      let(:solution) { FactoryGirl.create(:solution_string, regex: "^#{correct_answer}s?$") }

      it "returns true if the response is correct" do
        expect(solution.correct_response?(correct_answer)).to be_true
      end

      it "returns true if the correct response is pluralized" do
        expect(solution.correct_response?(correct_answer_pluralized)).to be_true
      end
    end

  end


end
