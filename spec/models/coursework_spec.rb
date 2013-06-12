# == Schema Information
#
# Table name: courseworks
#
#  id            :integer          not null, primary key
#  user_id       :integer          not null
#  assignment_id :integer          not null
#  completed     :boolean          default(FALSE), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

describe Coursework do
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:assignment) }
  
  it { should belong_to(:user) }
  it { should belong_to(:assignment) }
  it { should belong_to(:lesson) }

  context "with two courseworks" do

    let!(:user)        { FactoryGirl.create(:user) }
    let!(:assignment)  { FactoryGirl.create(:assignment) }
    let!(:coursework)  { FactoryGirl.create(:coursework, user: user, assignment: assignment) }

    it "is valid with different users on the same assignment" do
      other_coursework = FactoryGirl.build(:coursework, assignment: assignment)
      expect(other_coursework).to be_valid
    end

    it "is valid with the same user on different assignments" do
      other_coursework = FactoryGirl.build(:coursework, user: user)
      expect(other_coursework).to be_valid
    end

    it "is not valid with the same user and the same assignment" do
      other_coursework = FactoryGirl.build(:coursework, user: user, assignment: assignment)
      expect(other_coursework).to_not be_valid
    end

  end
  
end
