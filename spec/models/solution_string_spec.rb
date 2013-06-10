# == Schema Information
#
# Table name: solution_strings
#
#  id         :integer          not null, primary key
#  regex      :string(255)      not null
#  card_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe SolutionString do
  # it { should validate_presence_of(:regex) }
  # it { should validate_presence_of(:card) }
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
end
